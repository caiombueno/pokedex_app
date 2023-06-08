import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_bloc.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_list_event.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_state.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/pokemon_card_list/pokemon_card.dart';

class PokemonCardGridView extends StatelessWidget {
  const PokemonCardGridView({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCardGridBloc, PokemonCardGridState>(
      bloc: PokemonCardGridBloc(scrollController)
        ..add(FetchPokemonCardDataEvent()),
      builder: (context, state) {
        if (state is FetchPokemonCardDataSuccessState) {
          return Column(
            children: [
              GridView.builder(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return PokemonCard(state.pokemonCardDataList[index]);
                },
                itemCount: state.pokemonCardDataList.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1.5,
                ),
              ),
              (state.isLastPage)
                  ? const NoMorePokemonsMessage()
                  : const FetchMoreDataProgressIndicator(),
            ],
          );
        } else if (state is FetchPokemonCardDataFailState) {
          return Center(child: Text(state.exception.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}

class NoMorePokemonsMessage extends StatelessWidget {
  const NoMorePokemonsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: const Center(
        child: Text(
          'No more Pokémons to load :(',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

class FetchMoreDataProgressIndicator extends StatelessWidget {
  const FetchMoreDataProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
