import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_bloc.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_event.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_state.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/pokemon_card_list/pokemon_card.dart';

import '../../domain/pokemon_card_data.dart';

class PokemonCardListScreen extends StatelessWidget {
  const PokemonCardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonListBloc = PokemonListBloc();
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      bloc: pokemonListBloc,
      builder: (context, state) {
        pokemonListBloc.add(FetchPokemonsCardDataListEvent());
        if (state is PokemonCardListSuccessState) {
          final List<PokemonCardData> pokemonCardDataList =
              state.pokemonCardDataList;
          return GridView.builder(
            itemBuilder: (context, index) {
              return PokemonCard(pokemonCardDataList[index]);
            },
            itemCount: 10,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1.5,
            ),
          );
        } else if (state is PokemonCardListFailureState) {
          return Center(child: Text(state.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
