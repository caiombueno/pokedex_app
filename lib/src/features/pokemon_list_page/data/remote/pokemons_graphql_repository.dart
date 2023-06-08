import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex_app/src/exceptions/app_exception.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/data/remote/poke_api.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/mutable_record.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

class PokemonGraphQLRepository {
  late final PokeAPI _pokeAPI;
  PokemonGraphQLRepository() {
    _pokeAPI = PokeAPI();
  }

  Future<({List<PokemonCardData> data, bool isLastPage})> fetchPokemonCardsData(
      {required int pageKey}) async {
    const String query = """
      query Pokemon_card_data(\$offset: Int, \$limit: Int) {
        pokemon_v2_pokemon(offset: \$offset, limit: \$limit) {
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

    final QueryResult result = await _pokeAPI.makeQuery(
      query,
      {
        'offset': pageKey * 10,
        'limit': 10,
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
      isLastPage: pokemonCardDataList.last.pokemonId == 10271,
    );
  }
}
