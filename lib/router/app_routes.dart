import 'package:ella/features/steps/presentation/pages/steps_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login/login_page.dart';
import '../features/auth/presentation/pages/register/register_page.dart';
import 'name_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.login,
  // redirect: (context, state) async {
  //   return '/';
  // },
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
  ],
);
