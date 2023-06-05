import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

extension MutablePokemonCardData on PokemonCardData {
  PokemonCardData addColor(int cardColor) {
    return (
      pokemonId: this.pokemonId,
      pokemonName: this.pokemonName,
      pokemonTypes: this.pokemonTypes,
      sprite: this.sprite,
      cardColor: cardColor,
    );
  }
}
