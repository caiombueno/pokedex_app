import 'package:flutter/material.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/domain/pokemon_card_data.dart';

extension MutableRecord on ({
  int id,
  String pokemonName,
  List<String> pokemonTypes,
  Image sprite,
  int? cardColor,
}) {
  PokemonCardData toPokemonCardData() {
    final List<PokemonType> newPokemonTypes = [];
    for (var string in this.pokemonTypes) {
      newPokemonTypes.add(_stringToPokemonType(string));
    }

    final PokemonCardData pokemonCardData = (
      pokemonId: this.id,
      pokemonName: this.pokemonName,
      pokemonTypes: newPokemonTypes,
      sprite: this.sprite,
      cardColor: this.cardColor,
    );
    return pokemonCardData;
  }

  PokemonType _stringToPokemonType(String? string) {
    return switch (string) {
      'normal' => PokemonType.normal,
      'fire' => PokemonType.fire,
      'water' => PokemonType.water,
      'grass' => PokemonType.grass,
      'electric' => PokemonType.electric,
      'ice' => PokemonType.ice,
      'fighting' => PokemonType.fighting,
      'poison' => PokemonType.poison,
      'ground' => PokemonType.ground,
      'flying' => PokemonType.flying,
      'psychic' => PokemonType.psychic,
      'bug' => PokemonType.bug,
      'rock' => PokemonType.rock,
      'ghost' => PokemonType.ghost,
      'dark' => PokemonType.dark,
      'dragon' => PokemonType.dragon,
      'steel' => PokemonType.steel,
      'fairy' => PokemonType.fairy,
      _ => PokemonType.unknown,
    };
  }
}
