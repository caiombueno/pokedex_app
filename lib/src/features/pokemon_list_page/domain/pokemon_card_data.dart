import 'package:flutter/material.dart';

typedef PokemonCardData = ({
  int pokemonId,
  String pokemonName,
  List<PokemonType> pokemonTypes,
  Image sprite,
  int? cardColor,
});

enum PokemonType {
  normal,
  fire,
  water,
  grass,
  electric,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dark,
  dragon,
  steel,
  fairy,
  unknown,
}
