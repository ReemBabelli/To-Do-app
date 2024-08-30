import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/screens/side_bar_screen.dart';
import '../utilities/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;



  @override
  Widget build(BuildContext context) {
    String home = AppLocalizations.of(context)!.home;
    String tasksForToday = AppLocalizations.of(context)!.tasksForToday;
    String productivity = AppLocalizations.of(context)!.productivity;

    final List<String> titles = [
      home,
      tasksForToday,
      productivity
    ];

    final List<BottomNavigationBarItem> items =  [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: home),
      BottomNavigationBarItem(icon: const Icon(Icons.today), label: tasksForToday),
      BottomNavigationBarItem(
          icon: const Icon(Icons.incomplete_circle), label: productivity),
    ];

    return Scaffold(
        drawer: const SideBarScreen(),
        appBar: _buildAppBar(context , titles),
        body: navigationShell,
        bottomNavigationBar: _buildBottomNavigationBar(context , items));
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  _buildAppBar(BuildContext context , List<String> titles)   {

    return AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          titles[navigationShell.currentIndex],
          style: getWhiteTitle(context),
        ));
  }

  _buildBottomNavigationBar(BuildContext context  , List<BottomNavigationBarItem> items) {
    return BottomNavigationBar(
      selectedItemColor: Colors.amber,
      items: items,
      currentIndex: navigationShell.currentIndex,
      onTap: (int index) => _onTap(context, index),
    );
  }
}
