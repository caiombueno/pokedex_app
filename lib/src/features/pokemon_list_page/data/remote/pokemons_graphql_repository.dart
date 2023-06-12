import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex_app/src/constants/app_sizes.dart';
import 'package:pokedex_app/src/exceptions/app_exception.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/data/remote/poke_api.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/mutable_record.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

class PokemonGraphQLRepository {
  late final PokeAPI _pokeAPI;
  PokemonGraphQLRepository() {
    _pokeAPI = PokeAPI();
  }
  bool isLastPage = false;

  Future<({List<PokemonCardData> data, bool isLastPage})> fetchPokemonCardsData(
      {required int pageKey, required String searchByName}) async {
    const String query = """
      query Pokemon_card_data(\$offset: Int, \$limit: Int, \$where: pokemon_v2_pokemon_bool_exp) {
        pokemon_v2_pokemon(offset: \$offset, limit: \$limit, where: \$where) {
          id
          name
          pokemon_v2_pokemontypes {
            pokemon_v2_type {
              name
            }
          }
        }
      }
    """;

    const pageGap = 10;

    final QueryResult result = await _pokeAPI.makeQuery(
      query,
      {
        'offset': pageKey * pageGap,
        'limit': searchByName != '' ? null : pageGap,
        'where': {
          'name': {"_iregex": searchByName},
        },
      },
    );

    if (result.hasException) {
      throw CouldNotQueryDataException(result.exception!);
    }

    final List<PokemonCardData> pokemonCardDataList = [];
    final List<dynamic> data = result.data?['pokemon_v2_pokemon'];
    ({
      int id,
      String pokemonName,
      List<String> pokemonTypes,
      Image sprite,
      int? cardColor,
    }) pokemonData;

    for (var i = 0; i < data.length; i++) {
      final int pokemonId = data[i]?['id'];

      final String pokemonName = data[i]['name'];

      final List<String> pokemonTypes = [];
      for (var j = 0; j < data[i]['pokemon_v2_pokemontypes'].length; j++) {
        pokemonTypes.add(
            data[i]['pokemon_v2_pokemontypes'][j]['pokemon_v2_type']['name']);
      }

      assert(pokemonTypes.length <= 2);

      final sprite = Image.network(
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          width: 10.0,
          height: 60.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                size: 20.0,
              ),
              gapH4,
              Text(
                'Failed to load image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      );

      pokemonData = (
        id: pokemonId,
        pokemonName: pokemonName,
        pokemonTypes: pokemonTypes,
        sprite: sprite,
        cardColor: null,
      );

      pokemonCardDataList.add(pokemonData.toPokemonCardData());
    }

    return (
      data: pokemonCardDataList,
      isLastPage:
          pokemonCardDataList.last.pokemonId == 10271 || searchByName != '',
    );
  }
}
