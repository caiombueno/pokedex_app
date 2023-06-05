import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class LocalSVGRepository {
  static String _getAssetName(PokemonType pokemonType) =>
      'assets/pokemon_type/pokemon_type_icons/${pokemonType.name}.svg.vec';

  static AssetBytesLoader getPokemonTypeIconAssetLoader(
          PokemonType pokemonType) =>
      AssetBytesLoader(_getAssetName(pokemonType));

  static AssetBytesLoader getCardPokeballAssetLoader() =>
      const AssetBytesLoader(
        '/Users/caio/Projects/pokedex_app/assets/card_pokeball.svg.vec',
      );
}
