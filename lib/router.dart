import 'package:flutter/material.dart';
import 'package:flutter_auth_test/src/pages/home_page.dart';
import 'package:flutter_auth_test/src/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfilePage();
          },
        ),
      ],
    ),
  ],
);
