import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/db/database_managers.dart';
import '../pages/watchlist_entry_form.dart';
import '../pages/watchlist_update_form.dart';
import '../models/watchlist_movie.dart';
import '../db/movie_entry_dao.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  var movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() async {
    final databaseManager = WatchlistDatabaseManager.getInstance();
    final movieEntries = await WatchlistMovieDAO.movieEntries(databaseManager: databaseManager);
    setState(() {movies = movieEntries;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: movies.isEmpty ? welcome() : list(),
      floatingActionButton: fab(),
    );
  }

  Widget list () {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, count) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            child: ListTile(
              title: Text(movies[(movies.length - count - 1)].title), // Makes newest movie show up on top
              subtitle: movies[(movies.length - count - 1)].genre == '' ? const Text('Genre', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),) : Text(movies[(movies.length - count - 1)].genre),
              trailing: movies[(movies.length - count - 1)].date == '' ? const Text('Date', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),) : Text(DateFormat('yMMMd').format(DateTime.parse(movies[(movies.length - count - 1)].date))),
              onTap: () {pushWatchlistUpdateForm(context, movies[movies.length - count - 1]);},
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.pink,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(10),
              ), 
            ),
          );
        }),
    );
  }

  Widget welcome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,  
      children: const [
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Icon(
              Icons.movie_filter,
              size: 100,
            )
          )
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text('Welcome to your Watchlist!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20))
          )
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text('Please enter movies that you would like to watch.', textAlign: TextAlign.center)
          )
        ),
      ]
    );
  }

  Widget fab() {
    return FloatingActionButton(
      onPressed: () => pushWatchlistEntryForm(context),
      child: const Icon(Icons.add),);
  }

  void pushWatchlistEntryForm(BuildContext context) {
    Navigator.pushNamed(context, WatchlistEntryForm.routeName).then((_){
      loadMovies();
    });
  }
  
  void pushWatchlistUpdateForm(BuildContext context, WatchlistMovie movie) {
    Navigator.pushNamed(context, WatchlistUpdateForm.routeName, arguments: movie).then((_){
      loadMovies();
    });
  }

}