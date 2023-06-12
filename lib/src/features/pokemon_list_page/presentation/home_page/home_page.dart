import 'package:flutter/material.dart';
import 'package:pokedex_app/src/constants/app_sizes.dart';

import '../pokemon_card_list/pokemon_card_grid_view.dart';
import 'home_page_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.only(
        top: 100.0,
        left: 10.0,
        right: 10.0,
      ),
      child: ListView(
        controller: scrollController,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: [
          const HomePageTitle(),
          gapH4,
          const HomePageSubtitle(),
          gapH16,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: context.mounted
                    ? MediaQuery.of(context).size.width * 3 / 4
                    : 10,
                height: 55,
                child: HomePageSearchBar(
                  searchController: searchController,
                ),
              ),
              gapW8,
              const FilterIcon(),
            ],
          ),
          gapH24,
          PokemonCardGridView(
            searchController: searchController,
            scrollController: scrollController,
          ),
        ],
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
