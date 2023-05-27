import 'package:bloc/bloc.dart';

import '../../../routing/app_router.dart';

class AppNavigationBarBloc extends Cubit<int> {
  AppNavigationBarBloc() : super(0);
  void onItemTapped(int value) => emit(value);

  void getRoute(int state, void Function(String route) goRoute) {
    final route = switch (state) {
      1 => AppRoute.comparator.name,
      2 => AppRoute.quiz.name,
      3 => AppRoute.favorites.name,
      _ => AppRoute.home.name,
    };

    goRoute(route);
  }
}
