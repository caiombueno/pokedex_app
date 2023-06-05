import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

sealed class PokemonListState {}

class LoadingState extends PokemonListState {}

class PokemonCardListSuccessState extends PokemonListState {
  PokemonCardListSuccessState(this.pokemonCardDataList);
  final List<PokemonCardData> pokemonCardDataList;
}

class PokemonCardListFailureState extends PokemonListState {
  PokemonCardListFailureState(this.exception);
  final dynamic exception;
}
