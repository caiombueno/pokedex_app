import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_event.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_state.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/data/remote/pokemons_graphql_repository.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/mutable_pokemon_card_data.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';
import '../data/local/pokemon_type_color_repository.dart';

class PokemonCardGridBloc
    extends Bloc<PokemonCardGridEvent, PokemonCardGridState> {
  final ScrollController scrollController;
  final TextEditingController searchController;
  int pageKey = 0;

  PokemonCardGridBloc({
    required this.scrollController,
    required this.searchController,
  }) : super(LoadingState()) {
    bool isLastPage = false;
    final List<PokemonCardData> pokemonCardDataList = [];
    final graphQlRepository = PokemonGraphQLRepository();
    scrollController.addListener(
      () {
        if (scrollController.hasClients &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isLastPage) {
          pageKey++;
          add(FetchPokemonCardDataEvent(
            pageKey: pageKey,
          ));
        }
      },
    );

    Timer? timer;

    searchController.addListener(() async {
      if (timer?.isActive ?? false) timer?.cancel();
      timer = Timer(const Duration(milliseconds: 500), () {
        print('search called');
        add(FetchPokemonCardDataEvent(
          searchValue: searchController.text,
        ));
      });
    });

    on<FetchPokemonCardDataEvent>(
      (event, emit) async {
        if (event.searchValue != '' && event.searchValue != null) {
          emit(LoadingState());
        }
        try {
          final fetchResponse = await graphQlRepository.fetchPokemonCardsData(
            searchByName: event.searchValue ?? '',
            pageKey: event.pageKey,
          );
          final newData = fetchResponse.data;
          final pokemonTypeColorData =
              await PokemonTypeColorRepository.getPokemonTypeColorData();
          final List<PokemonCardData> newDataWithColor = [];
          int cardColor;
          for (var pokemonCardData in newData) {
            cardColor = PokemonTypeColorRepository.getPokemonTypeColor(
              pokemonTypeColorData,
              pokemonCardData.pokemonTypes[0],
            );
            newDataWithColor.add(
              pokemonCardData.addColor(cardColor),
            );
          }

          if (event.searchValue != null) pokemonCardDataList.clear();

          pokemonCardDataList.addAll(newDataWithColor);
          isLastPage = fetchResponse.isLastPage;

          emit(
            FetchCardDataSuccessState(
                pokemonCardDataList: pokemonCardDataList,
                isLastPage: isLastPage),
          );
        } catch (e) {
          emit(FetchCardDataFailureState(e));
        }
      },
    );
  }
}


//* using infinite scroll pagination package and cubit
// class PokemonCardGridBloc extends Cubit<void> {
//   final PagingController<int, PokemonCardData> pagingController;
//   PokemonCardGridBloc(this.pagingController) : super(0) {
//     print('call constructor');
//     pagingController.addPageRequestListener((pageKey) {
//       print('page request');
//       fetchPokemonCardData(pageKey);
//     });
//   }
//   final repository = PokemonGraphQLRepository();

//   void fetchPokemonCardData(int pageKey) async {
//     try {
//       final fetchResponse = await repository.fetchPokemonCardsData(
//         pageKey: pageKey,
//       );
//       final newData = fetchResponse.data;
//       final pokemonTypeColorData =
//           await PokemonTypeColorRepository.getPokemonTypeColorData();
//       final List<PokemonCardData> newDataWithColor = [];
//       int cardColor;
//       for (var pokemonCardData in newData) {
//         cardColor = PokemonTypeColorRepository.getPokemonTypeColor(
//           pokemonTypeColorData,
//           pokemonCardData.pokemonTypes[0],
//         );
//         newDataWithColor.add(
//           pokemonCardData.addColor(cardColor),
//         );
//       }

//       // for (var element in newDataWithColor) {
//       //   print(element.pokemonId);
//       // }

//       bool isLastPage = fetchResponse.isLastPage;

//       if (isLastPage) {
//         pagingController.appendLastPage(newDataWithColor);
//       } else {
//         pageKey++;
//         pagingController.appendPage(newDataWithColor, pageKey);
//       }
//     } catch (e) {
//       pagingController.error = e;
//     }
//   }
// }
