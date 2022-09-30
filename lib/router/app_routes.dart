import 'package:ella/features/main/presentation/pages/main_page.dart';
import 'package:ella/features/steps/presentation/pages/steps_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/local_source/local_source.dart';
import '../features/auth/presentation/pages/login/login_page.dart';
import '../features/auth/presentation/pages/register/register_page.dart';
import '../injector_container.dart';
import 'name_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRootNavigatorKey = GlobalKey<NavigatorState>();
final localSource = sl<LocalSource>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.home,
  redirect: (context, state) async {
    if ((localSource.getAccessToken() ?? '').isEmpty &&
        state.subloc != Routes.login) {
      return Routes.login;
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: Routes.steps,
      builder: (context, state) => const StepsPage(),
    ),
    ShellRoute(
      navigatorKey: shellRootNavigatorKey,
      builder: (context, routerState, child) => MainPage(
        child: child,
      ),
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => Container(
            color: Colors.green,
          ),
        ),
        GoRoute(
          path: Routes.calendar,
          builder: (context, state) => Container(
            color: Colors.red,
          ),
        ),
        GoRoute(
          path: Routes.advices,
          builder: (context, state) => Container(
            color: Colors.yellow,
          ),
        ),
        GoRoute(
          path: Routes.magicChat,
          builder: (context, state) => Container(
            color: Colors.amber,
          ),
        ),
        GoRoute(
          path: Routes.profile,
          builder: (context, state) => Container(
            color: Colors.blue,
          ),
        ),
      ],
    ),
  ],
);
