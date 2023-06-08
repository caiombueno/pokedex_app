// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_event.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_state.dart';

import 'package:pokedex_app/src/features/pokemon_list_page/data/remote/pokemons_graphql_repository.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/mutable_pokemon_card_data.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

import '../data/local/pokemon_type_color_repository.dart';

class PokemonCardGridBloc extends Bloc<PokemonListEvent, PokemonCardGridState> {
  late final PokemonGraphQLRepository repository;
  PokemonCardGridBloc(ScrollController scrollController)
      : super(FetchPokemonCardDataLoadingState()) {
    final repository = PokemonGraphQLRepository();
    List<PokemonCardData> pokemonCardDataList = [];
    int pageKey = 0;
    bool isLastPage = false;

    scrollController.addListener(() {
      bool hasReachedEnd = scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange;
      if (hasReachedEnd && !isLastPage) {
        add(
          FetchPokemonCardDataEvent(),
        );
      }
    });

    on<FetchPokemonCardDataEvent>(
      (event, emit) async {
        try {
          final fetchResponse = await repository.fetchPokemonCardsData(
            pageKey: pageKey,
          );
          isLastPage = fetchResponse.isLastPage;
          final newData = fetchResponse.data;
          final pokemonTypeColorData =
              await PokemonTypeColorRepository.getPokemonTypeColorData();
          final List<PokemonCardData> pokemonCardDataWithColorList = [];
          int cardColor;
          for (var pokemonCardData in newData) {
            cardColor = PokemonTypeColorRepository.getPokemonTypeColor(
              pokemonTypeColorData,
              pokemonCardData.pokemonTypes[0],
            );
            pokemonCardDataWithColorList.add(
              pokemonCardData.addColor(cardColor),
            );
          }
          for (var element in pokemonCardDataWithColorList) {
            print(element.pokemonId);
          }

          pokemonCardDataList.addAll(pokemonCardDataWithColorList);
          pageKey++;
          emit(FetchPokemonCardDataSuccessState(
            pokemonCardDataList: pokemonCardDataList,
            isLastPage: isLastPage,
          ));
        } catch (e) {
          emit(FetchPokemonCardDataFailState(e));
        }
      },
    );
  }
}
