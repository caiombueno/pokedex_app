import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../exceptions/app_exception.dart';
import '../../domain/pokemon_card_data.dart';

class PokemonTypeColorRepository {
  static Future<String> get _getJsonFile async => await rootBundle
      .loadString('assets/pokemon_type/pokemon_type_color.json');

  static Future getPokemonTypeColorData() async {
    final json = await _getJsonFile;
    final data = jsonDecode(json);
    return data['pokemon_type_colors'];
  }

  static int getPokemonTypeColor(
      List pokemonTypeColorData, PokemonType pokemonType) {
    final color = pokemonTypeColorData.firstWhere(
        (element) => element['pokemon_type'] == pokemonType.name)['color'];
    if (color == null) {
      throw PokemonTypeColorNotFoundException;
    }
    return int.parse(color);
  }
}
