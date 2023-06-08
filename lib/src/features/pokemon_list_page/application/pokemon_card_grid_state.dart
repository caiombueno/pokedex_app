import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

sealed class PokemonCardGridState {}

class FetchPokemonCardDataLoadingState extends PokemonCardGridState {}

class FetchPokemonCardDataSuccessState extends PokemonCardGridState {
  FetchPokemonCardDataSuccessState({
    required this.pokemonCardDataList,
    required this.isLastPage,
  });
  final List<PokemonCardData> pokemonCardDataList;
  final bool isLastPage;
}

class FetchPokemonCardDataFailState extends PokemonCardGridState {
  FetchPokemonCardDataFailState(this.exception);
  final dynamic exception;
}
