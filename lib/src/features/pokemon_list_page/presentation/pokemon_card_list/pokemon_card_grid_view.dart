import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/src/constants/app_sizes.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/application/pokemon_card_grid_state.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/pokemon_card_list/pokemon_card.dart';

import '../../application/pokemon_card_grid_bloc.dart';
import '../../application/pokemon_card_grid_event.dart';

class PokemonCardGridView extends StatelessWidget {
  const PokemonCardGridView({
    super.key,
    required this.searchController,
    required this.scrollController,
  });
  final TextEditingController searchController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCardGridBloc, PokemonCardGridState>(
      bloc: PokemonCardGridBloc(
        scrollController: scrollController,
        searchController: searchController,
      )..add(
          FetchPokemonCardDataEvent(),
        ),
      builder: (context, state) {
        if (state is FetchCardDataSuccessState) {
          return Column(
            children: [
              GridView.builder(
                padding: const EdgeInsets.all(0),
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) =>
                    PokemonCard(state.pokemonCardDataList[index]),
                itemCount: state.pokemonCardDataList.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1.5,
                ),
              ),
              SizedBox(
                height: 80.0,
                child: !state.isLastPage
                    ? const ProgressIndicator()
                    : const Center(
                        child: Text('Nothing more to show'),
                      ),
              ),
            ],
          );
        } else if (state is FetchCardDataFailureState) {
          return const FirstPageErrorIndicator();
        } else {
          return const ProgressIndicator();
        }
      },
    );
  }
}

//* using infinite scroll pagination package without bloc
// class PokemonCardGridView extends StatefulWidget {
//   const PokemonCardGridView({
//     super.key,
//   });

//   @override
//   State<PokemonCardGridView> createState() => _PokemonCardGridViewState();
// }

// class _PokemonCardGridViewState extends State<PokemonCardGridView> {
//   final PagingController<int, PokemonCardData> pagingController =
//       PagingController(firstPageKey: 0);

//   final repository = PokemonGraphQLRepository();

//   Future<void> fetchPage(int pageKey) async {
//     try {
//       final fetchResponse = await repository.fetchPokemonCardsData(
//         pageKey: pageKey,
//       );
//       final newData = fetchResponse.data;
//       final pokemonTypeColorData =
//           await PokemonTypeColorRepository.getPokemonTypeColorData();
//       final List<PokemonCardData> newDataWithColor = [];
//       int cardColor;
//       for (var pokemonCardData in newData) {
//         cardColor = PokemonTypeColorRepository.getPokemonTypeColor(
//           pokemonTypeColorData,
//           pokemonCardData.pokemonTypes[0],
//         );
//         newDataWithColor.add(
//           pokemonCardData.addColor(cardColor),
//         );
//       }

//       bool isLastPage = fetchResponse.isLastPage;

//       if (isLastPage) {
//         pagingController.appendLastPage(newDataWithColor);
//       } else {
//         pageKey++;
//         pagingController.appendPage(newDataWithColor, pageKey);
//       }
//     } catch (e) {
//       pagingController.error = e;
//     }
//   }

//   @override
//   void dispose() {
//     pagingController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     pagingController.addPageRequestListener((pageKey) async {
//       await fetchPage(pageKey);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PagedSliverGrid(
//       pagingController: pagingController,
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 300,
//         childAspectRatio: 1.5,
//       ),
//       builderDelegate: PagedChildBuilderDelegate<PokemonCardData>(
//         itemBuilder: (context, data, index) {
//           return PokemonCard(data);
//         },
//         firstPageProgressIndicatorBuilder: (context) =>
//             const ProgressIndicator(),
//         firstPageErrorIndicatorBuilder: (context) =>
//             FirstPageErrorIndicator(pagingController: pagingController),
//       ),
//     );
//   }
// }

//* using infinite scroll pagination package with cubit and stateless widget
// class PokemonCardGridView extends StatelessWidget {
//   const PokemonCardGridView({
//     super.key,
//     required this.scrollController,
//     required this.searchController,
//   });
//   final ScrollController scrollController;
//   final TextEditingController searchController;

//   @override
//   Widget build(BuildContext context) {
//     final PagingController<int, PokemonCardData> pagingController =
//         PagingController(firstPageKey: 0);
//     return BlocBuilder<PokemonCardGridBloc, void>(
//       bloc: PokemonCardGridBloc(pagingController),
//       builder: (context, _) => PagedSliverGrid(
//         pagingController: pagingController,
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 300,
//           childAspectRatio: 1.5,
//         ),
//         builderDelegate: PagedChildBuilderDelegate<PokemonCardData>(
//           itemBuilder: (context, data, index) {
//             return PokemonCard(data);
//           },
//           firstPageProgressIndicatorBuilder: (context) =>
//               const ProgressIndicator(),
//           firstPageErrorIndicatorBuilder: (context) =>
//               FirstPageErrorIndicator(pagingController: pagingController),
//         ),
//       ),
//     );
//   }
// }

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15.0,
        ),
        child: Column(
          children: [
            Text(
              'Oh snap!',
              style: TextStyle(fontSize: 20.0),
            ),
            gapH12,
            Text(
              'Something went wrong trying to search for Pokémons.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            gapH8,
            Text(
              'Please try again later.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
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
