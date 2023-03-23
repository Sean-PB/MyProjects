import 'package:flutter/material.dart';
import 'package:movie_catalog/pages/seen_list_entry_form.dart';
import 'package:movie_catalog/pages/watchlist_entry_form.dart';
import 'package:movie_catalog/pages/watchlist_update_form.dart';
import 'package:movie_catalog/pages/seen_list_update_form.dart';
import 'main_page.dart';

class App extends StatelessWidget {
  App({super.key});

  static final routes = {
    MainPage.routeName: (context) => const MainPage(),
    SeenListEntryForm.routeName: (context) => const SeenListEntryForm(),
    WatchlistEntryForm.routeName: (context) => const WatchlistEntryForm(),
    SeenListUpdateForm.routeName: (context) => const SeenListUpdateForm(),
    WatchlistUpdateForm.routeName: (context) => const WatchlistUpdateForm(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
