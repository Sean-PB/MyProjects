import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/db/database_managers.dart';
import '../pages/seen_list_entry_form.dart';
import '../pages/seen_list_update_form.dart';
import '../models/seen_list_movie.dart';
import '../db/movie_entry_dao.dart';

class SeenListPage extends StatefulWidget {
  const SeenListPage({super.key});

  @override
  State<SeenListPage> createState() => _SeenListPageState();
}

class _SeenListPageState extends State<SeenListPage> {
  var movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() async {
    final databaseManager = SeenListDatabaseManager.getInstance();
    final movieEntries = await SeenListMovieDAO.movieEntries(databaseManager: databaseManager);
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
              leading: Text('${movies[(movies.length - count - 1)].rating == -1 ? '-' : movies[(movies.length - count - 1)].rating.toString()}/5', style: const TextStyle(fontSize: 25)),
              title: Text(movies[(movies.length - count - 1)].title), // Makes newest movie show up on top
              subtitle: movies[(movies.length - count - 1)].genre == '' ? const Text('Genre', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),) : Text(movies[(movies.length - count - 1)].genre),
              trailing: movies[(movies.length - count - 1)].date == '' ? const Text('Date', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)) : Text(DateFormat('yMMMd').format(DateTime.parse(movies[(movies.length - count - 1)].date))),
              onTap: () {pushSeenListUpdateForm(context, movies[movies.length - count - 1]);},
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.purple, width: 2),
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
              Icons.movie_outlined,
              size: 100,
            )
          )
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text('Welcome to your Seen List!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          )
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text('Please enter movies that you have seen.', textAlign: TextAlign.center)
          )
        ),
      ]
    );
  }

  Widget fab() {
    return FloatingActionButton(
      onPressed: () => pushSeenListEntryForm(context),
      child: const Icon(Icons.add),);
  }

  void pushSeenListEntryForm(BuildContext context) {
    Navigator.pushNamed(context, SeenListEntryForm.routeName).then((_){
      loadMovies();
    });
  }

  void pushSeenListUpdateForm(BuildContext context, SeenListMovie movie) {
    Navigator.pushNamed(context, SeenListUpdateForm.routeName, arguments: movie).then((_){
      loadMovies();
    });
  }

}