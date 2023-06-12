import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_app/src/constants/app_sizes.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/data/local/local_svg_repository.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/pokemon_card_list/pokemon_type_badge.dart';
import 'package:pokedex_app/src/utils/capitalize_first_char.dart';
import 'package:vector_graphics/vector_graphics.dart';

class PokemonCard extends StatelessWidget {
  PokemonCard(this.data, {super.key}) {
    pokemonId = data.pokemonId;
    pokemonName = data.pokemonName;
    pokemonTypes = data.pokemonTypes;
    sprite = data.sprite;
    cardColor = data.cardColor ?? 0xFFFFFFFF;
  }
  final PokemonCardData data;
  late final int pokemonId;
  late final String pokemonName;
  late final List<PokemonType> pokemonTypes;
  late final Image sprite;
  late final int cardColor;

  String _pokemonIdToCard() {
    return switch (pokemonId.toString().length) {
      1 => '#00$pokemonId',
      2 => '#0$pokemonId',
      _ => '#$pokemonId',
    };
  }

  Text _cardText(String text, double fontSize) => Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 150,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Color(cardColor),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            left: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // pokemonName and pokemonId
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 120, maxHeight: 20),
                    child: _cardText(
                      pokemonName.capitalizeFirstChar(),
                      15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: _cardText(
                      _pokemonIdToCard(),
                      13,
                    ),
                  ),
                ],
              ),

              // pokemonTypeBadges and sprite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PokemonTypeBadge(
                          pokemonType: pokemonTypes[0],
                        ),
                        gapH4,
                        if (pokemonTypes.length > 1)
                          PokemonTypeBadge(pokemonType: pokemonTypes[1]),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    fit: StackFit.passthrough,
                    children: [
                      buildCardPokeball(),
                      SizedBox(width: 90.0, child: sprite),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardPokeball() {
    final AssetBytesLoader assetLoader =
        LocalSVGRepository.getCardPokeballAssetLoader();
    return ConstrainedBox(
      constraints: BoxConstraints(),
      child: SvgPicture(
        assetLoader,
      ),
    );
  }
}
