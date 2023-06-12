import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

sealed class PokemonCardGridState {}

class LoadingState extends PokemonCardGridState {}

class FetchCardDataSuccessState extends PokemonCardGridState {
  FetchCardDataSuccessState({
    required this.isLastPage,
    required this.pokemonCardDataList,
  });
  final List<PokemonCardData> pokemonCardDataList;
  final bool isLastPage;
}

class FetchCardDataFailureState extends PokemonCardGridState {
  FetchCardDataFailureState(this.exception);
  final dynamic exception;
}
