import 'package:flutter/material.dart';
import '../pages/watchlist.dart';
import '../pages/seen_list.dart';


class MainTabController extends StatelessWidget {
  MainTabController({super.key});

  static const tabs = [
    Tab(text: 'Watchlist'),
    Tab(text: 'Seen List'),
  ];

  final screens = [
    const WatchlistPage(),
    const SeenListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Movie Catalog'),
          bottom: const TabBar(tabs: tabs)
        ),
        body: TabBarView(children: screens)
      )
    );
  }
}