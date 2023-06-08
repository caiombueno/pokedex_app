sealed class PokemonListEvent {}

class FetchPokemonCardDataEvent extends PokemonListEvent {
  final int pageKey;

  FetchPokemonCardDataEvent({this.pageKey = 0});
}
