sealed class PokemonCardGridEvent {}

class FetchPokemonCardDataEvent extends PokemonCardGridEvent {
  int pageKey;
  String? searchValue;

  FetchPokemonCardDataEvent({this.pageKey = 0, this.searchValue});
}
