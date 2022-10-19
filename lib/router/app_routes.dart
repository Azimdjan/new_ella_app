import 'package:ella/core/page_arguments/article_page_params.dart';
import 'package:ella/features/advices/presentation/pages/article/article_page.dart';
import 'package:ella/features/advices/presentation/pages/guid/guid_page.dart';
import 'package:ella/features/main/presentation/pages/main_page.dart';
import 'package:ella/features/steps/presentation/pages/steps_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/local_source/local_source.dart';
import '../core/page_arguments/guid_page_params.dart';
import '../features/advices/presentation/pages/category_list/category_list_page.dart';
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
      name: Routes.login,
      path: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: Routes.register,
      path: Routes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: Routes.steps,
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
          name: Routes.home,
          path: Routes.home,
          builder: (context, state) => Container(
            color: Colors.green,
          ),
        ),
        GoRoute(
          name: Routes.calendar,
          path: Routes.calendar,
          builder: (context, state) => Container(
            color: Colors.red,
          ),
        ),
        GoRoute(
          name: Routes.advices,
          path: Routes.advices,
          builder: (context, state) => const CategoryListPage(),
        ),
        GoRoute(
          name: Routes.magicChat,
          path: Routes.magicChat,
          builder: (context, state) => Container(
            color: Colors.amber,
          ),
        ),
        GoRoute(
          name: Routes.profile,
          path: Routes.profile,
          builder: (context, state) => Container(
            color: Colors.blue,
          ),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: Routes.guide,
      path: Routes.guide,
      builder: (context, state) => GuidPage(
        params: state.extra as GuidPageParams,
      ),
    ),
    GoRoute(
      name: Routes.article,
      path: Routes.article,
      builder: (context, state) => ArticlePage(
        params: state.extra as ArticlePageParams,
      ),
    ),
  ],
);
