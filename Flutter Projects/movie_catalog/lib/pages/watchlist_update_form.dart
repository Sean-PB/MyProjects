import 'package:flutter/material.dart';
import 'package:movie_catalog/db/database_managers.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/pages/seen_list_entry_form.dart';
import '../db/movie_entry_dto.dart';
import '../models/watchlist_movie.dart';

class WatchlistUpdateForm extends StatefulWidget {
  const WatchlistUpdateForm({super.key});

  static const routeName = 'WatchlistAdd';

  @override
  State<WatchlistUpdateForm> createState() => _WatchlistUpdateForm();
}

class _WatchlistUpdateForm extends State<WatchlistUpdateForm> {

  final formKey = GlobalKey<FormState>();
  final movieEntryFields = WatchlistMovieEntryFields();
  final TextEditingController _dateField = TextEditingController();
  DateTime _date = DateTime.now();
  var displayDate;

  @override
  Widget build(BuildContext context) {

    final WatchlistMovie movie = ModalRoute.of(context)?.settings.arguments as WatchlistMovie;
    if (displayDate != null){
      _dateField.text = displayDate;
    }
    else if (movie.date != ''){
      _dateField.text = DateFormat('yMMMd').format(DateTime.parse(movie.date));
    }
    else {
      _dateField.text = '';
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Update Movie From Watchist'),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column ( 
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: movie.title,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder()
                    ),
                    onSaved: (value) {
                      movieEntryFields.title = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      else {
                        return null;
                      }
                    }
                  ),
                  const SizedBox(height: 10),  
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    initialValue: movie.genre,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                      border: OutlineInputBorder()
                    ),
                    onSaved: (value) {
                      if (value == null || value == '') {
                        movieEntryFields.genre = '';
                      }
                      else {
                        movieEntryFields.genre = value;
                      }
                    }
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dateField,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                    onTap:() async {
                      DateTime initialDate;
                      if (_date != DateTime.now()) { // This would mean that the user entered a date in the form and then wanted to rechange it which is why it comes first
                        initialDate = _date;
                      }
                      else if (movie.date != '') {
                        initialDate = DateTime.parse(movie.date);
                      }
                      else {
                        initialDate = DateTime.now();
                      }
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime.utc(1888, 8, 14),
                        lastDate: DateTime(2100),
                      );
                      if (date != null){
                        setState(() {
                          _date = date;
                          _dateField.text = DateFormat('yMMMd').format(date);
                          displayDate = DateFormat('yMMMd').format(date);
                        });
                      }
                    },
                    onSaved: (value) {
                      if (value == null || value == '') {
                        movieEntryFields.date = '';
                      }
                      else {
                        movieEntryFields.date = _date.toString();
                      }
                    }
                  ),
                  const SizedBox(height: 20),  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final database = WatchlistDatabaseManager.getInstance();
                            await database.db.delete(
                              'watchlist_movie_entries',
                              where: 'id = ?',
                              whereArgs: [movie.id]
                            );
                          
                            Navigator.of(context).pop();
                            
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete Movie') 
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                      
                              final database = WatchlistDatabaseManager.getInstance();
                              await database.db.update(
                                'watchlist_movie_entries', 
                                {
                                  'title': movieEntryFields.title,
                                  'genre': movieEntryFields.genre,
                                  'date': movieEntryFields.date
                                },
                                where: 'id = ?',
                                whereArgs: [movie.id]
                              );
                          
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          icon: const Icon(Icons.save_alt),
                          label: const Text('Save Movie')
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {                 
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                      
                          // Save fields to movie
                          WatchlistMovie newSeenListMovie = WatchlistMovie(
                            id: movie.id, 
                            title: movieEntryFields.title, 
                            genre: movieEntryFields.genre, 
                            date: movieEntryFields.date
                          );
                          
                          // Move movie to seen list entry form
                          pushSeenListEntryForm(context, newSeenListMovie);
                        }
                      },
                      icon: const Icon(Icons.check_box), 
                      label: const Text('Move Movie To Seen List')
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  void pushSeenListEntryForm(BuildContext context, WatchlistMovie movie) {
    Navigator.pushNamed(context, SeenListEntryForm.routeName, arguments: movie).then((_){
    });
  }
}