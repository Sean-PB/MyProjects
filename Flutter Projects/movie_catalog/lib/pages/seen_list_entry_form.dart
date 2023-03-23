import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/db/database_managers.dart';
import 'package:movie_catalog/models/watchlist_movie.dart';
import '../components/dropdown_rating_form_field.dart';
import '../db/movie_entry_dto.dart';

class SeenListEntryForm extends StatefulWidget {
  const SeenListEntryForm({super.key});

  static const routeName = 'SeenListAdd';

  @override
  State<SeenListEntryForm> createState() => _SeenListEntryForm();
}

class _SeenListEntryForm extends State<SeenListEntryForm> {

  final formKey = GlobalKey<FormState>();
  final movieEntryFields = SeenListMovieEntryFields();
  final TextEditingController _dateField = TextEditingController();
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    WatchlistMovie? movie;
    if (ModalRoute.of(context)?.settings.arguments != null){
      movie = ModalRoute.of(context)?.settings.arguments as WatchlistMovie;
    }

    if (movie?.date != null){
      _dateField.text = movie?.date == ''? '' : DateFormat('yMMMd').format(DateTime.parse(movie!.date));
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Movie to Seen List'),
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
                    initialValue: movie?.title,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
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
                  DropdownRatingFormField(
                    hint: const Text('Rating'),
                    maxRating: 6,
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      if (value == null || value == '') {
                        movieEntryFields.rating = -1;
                      }
                      else {
                        movieEntryFields.rating = value;
                      }
                    }
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    initialValue: movie?.genre,
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
                      DateTime? date = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.utc(1888, 8, 14), 
                        lastDate: DateTime.now()
                      );
                      if (date != null){
                        setState(() {
                          _date = date;
                          _dateField.text = DateFormat('yMMMd').format(date);
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
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // Save the input into the seen list database
                              formKey.currentState!.save();
                              final databaseManger = SeenListDatabaseManager.getInstance();
                              databaseManger.saveMovieEntry(dto: movieEntryFields);

                              // If this is a movie from the watchlist
                              if (movie != null) {
                                // Delete the movie from the watchlist database
                                final database = WatchlistDatabaseManager.getInstance();
                                await database.db.delete(
                                  'watchlist_movie_entries',
                                  where: 'id = ?',
                                  whereArgs: [movie.id]
                                );

                                // Navigate 2 pages back (to the watchlist)
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                              else {
                                // Navigate 1 page back (to the seen list)
                                Navigator.of(context).pop();
                              }

                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Save Movie')
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}