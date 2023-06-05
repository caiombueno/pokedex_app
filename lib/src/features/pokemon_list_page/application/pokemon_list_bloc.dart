// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_event.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_state.dart';

import 'package:pokedex_app/src/features/pokemon_list_page/data/remote/pokemons_graphql_repository.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/mutable_pokemon_card_data.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

import '../data/local/pokemon_type_color_repository.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  late final PokemonGraphQLRepository repository;
  PokemonListBloc() : super(LoadingState()) {
    repository = PokemonGraphQLRepository();

    on<FetchPokemonsCardDataListEvent>((event, emit) async {
      try {
        final pokemonCardDataList = await repository.fetchPokemonCardsData();
        final pokemonTypeColorData =
            await PokemonTypeColorRepository.getPokemonTypeColorData();
        final List<PokemonCardData> pokemonCardDataWithColorList = [];
        int cardColor;
        for (var pokemonCardData in pokemonCardDataList) {
          cardColor = PokemonTypeColorRepository.getPokemonTypeColor(
            pokemonTypeColorData,
            pokemonCardData.pokemonTypes[0],
          );
          pokemonCardDataWithColorList.add(
            pokemonCardData.addColor(cardColor),
          );
        }
        emit(PokemonCardListSuccessState(pokemonCardDataWithColorList));
      } catch (e) {
        emit(PokemonCardListFailureState(e));
      }
    });
  }
}
