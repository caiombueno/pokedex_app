import 'package:flutter/material.dart';
import 'package:pokedex_app/src/constants/app_sizes.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/pokemon_card_list/pokemon_card_list_screen.dart';
import 'package:pokedex_app/src/features/pokemon_list_page/presentation/home_page/home_page_search_bar.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 35,
          horizontal: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HomePageTitle(),
            gapH4,
            const HomePageSubtitle(),
            gapH16,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  height: 55,
                  child: const HomePageSearchBar(),
                ),
                gapW8,
                const FilterIcon(),
              ],
            ),
            gapH24,
            const PokemonCardListScreen(),
          ],
        ),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDFE4EC),
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: 55,
      width: 55,
      child: const Icon(
        Icons.filter_alt_outlined,
      ),
    );
  }
}

class HomePageSubtitle extends StatelessWidget {
  const HomePageSubtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Use the advanced search to find Pokémon by type, weakness, ability and more!',
      style: TextStyle(
        height: 1.5,
        fontFamily: 'Roboto',
        fontSize: 16.0,
      ),
    );
  }
}

class HomePageTitle extends StatelessWidget {
  const HomePageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Pokédex',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 36.0,
      ),
    );
  }
}
