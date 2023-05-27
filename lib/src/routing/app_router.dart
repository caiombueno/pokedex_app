import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_scaffold.dart';

enum AppRoute {
  home,
  comparator,
  quiz,
  favorites,
}

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: AppRoute.home.name,
            builder: (context, state) => const Center(
              child: Text('Home'),
            ),
          ),
          GoRoute(
            path: '/comparator',
            name: AppRoute.comparator.name,
            builder: (context, state) => const Center(
              child: Text('Comparator'),
            ),
          ),
          GoRoute(
            path: '/quiz',
            name: AppRoute.quiz.name,
            builder: (context, state) => const Center(
              child: Text('Quiz'),
            ),
          ),
          GoRoute(
            path: '/favorites',
            name: AppRoute.favorites.name,
            builder: (context, state) => const Center(
              child: Text('Favorites'),
            ),
          )
        ],
      ),
    ],
  );
}
