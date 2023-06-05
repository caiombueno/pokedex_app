import 'package:flutter/material.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/data/local/local_svg_repository.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';
import 'package:pokedex_app/src/utils/capitalize_first_char.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class PokemonTypeBadge extends StatelessWidget {
  const PokemonTypeBadge({
    super.key,
    required this.pokemonType,
  });
  final PokemonType pokemonType;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(
        left: 0,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(51, 40, 49, 65),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSVGIconWidget(pokemonType),
          Text(
            pokemonType.name.capitalizeFirstChar(),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSVGIconWidget(PokemonType pokemonType) {
    final AssetBytesLoader assetLoader =
        LocalSVGRepository.getPokemonTypeIconAssetLoader(pokemonType);
    return SvgPicture(
      assetLoader,
      semanticsLabel: 'A ${pokemonType.name} Pokémon type symbol',
      width: 30,
      height: 30,
    );
  }
}
