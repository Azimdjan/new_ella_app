import 'package:ella/generated/l10n.dart';
import 'package:ella/router/name_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({Key? key, required this.child}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization();
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        onTap: (index) => changeTap(context, index),
        selectedLabelStyle: Theme.of(context).textTheme.bodyText2,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            label: localization.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.calendar_month,
              color: Theme.of(context).primaryColor,
            ),
            label: localization.calendar,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ),
            label: localization.advices,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.chat,
              color: Theme.of(context).primaryColor,
            ),
            label: localization.magic_chat,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            label: localization.profile,
          ),
        ],
      ),
    );
  }

  void changeTap(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });
    switch (index) {
      case 0:
        context.goNamed(Routes.home);
        break;
      case 1:
        context.goNamed(Routes.calendar);
        break;
      case 2:
        context.goNamed(Routes.advices);
        break;
      case 3:
        context.goNamed(Routes.magicChat);
        break;
      case 4:
        context.goNamed(Routes.profile);
        break;
    }
  }
}
