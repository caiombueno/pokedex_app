import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../application/app_navigation_bar_bloc.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appNavigationBarBloc = AppNavigationBarBloc();
    final screenHeight = MediaQuery.of(context).size.height;
    // add responsiveness to bottom navigation size
    final responsiveAppNavigationHeight =
        screenHeight >= 660 ? screenHeight / 12 : 80.0;

    return BlocConsumer<AppNavigationBarBloc, int>(
      bloc: appNavigationBarBloc,
      listener: (context, state) {
        appNavigationBarBloc.getRoute(state, context.goNamed);
      },
      builder: (context, state) {
        return SizedBox(
          height: responsiveAppNavigationHeight,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows_rounded),
                  label: "Comparator"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.quiz_outlined), label: "Quiz"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "Favorites"),
            ],
            currentIndex: state,
            onTap: appNavigationBarBloc.onItemTapped,
          ),
        );
      },
    );
  }
}