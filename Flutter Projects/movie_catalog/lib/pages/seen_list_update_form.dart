import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/db/database_managers.dart';
import '../components/dropdown_rating_form_field.dart';
import '../db/movie_entry_dto.dart';
import '../models/seen_list_movie.dart';

class SeenListUpdateForm extends StatefulWidget {
  const SeenListUpdateForm({super.key});

  static const routeName = 'SeenListUpdate';

  @override
  State<SeenListUpdateForm> createState() => _SeenListUpdateFormState();
}

class _SeenListUpdateFormState extends State<SeenListUpdateForm> {

  final formKey = GlobalKey<FormState>();
  final movieEntryFields = SeenListMovieEntryFields();
  final TextEditingController _dateField = TextEditingController();
  DateTime _date = DateTime.now();
  var displayDate;

  @override
  Widget build(BuildContext context) {
    
    final SeenListMovie movie = ModalRoute.of(context)?.settings.arguments as SeenListMovie;
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
          title: const Text('Update Movie From Seen List'),
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
                    textCapitalization: TextCapitalization.sentences,
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
                  DropdownRatingFormField(
                    hint: Text('${movie.rating == -1 ? "Rating" : movie.rating}'),
                    maxRating: 6,
                    validator: (value) {return null;},
                    onSaved: (value) {
                      movieEntryFields.rating = value ?? movie.rating; // null check
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
                        lastDate: DateTime.now(),
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
                            final database = SeenListDatabaseManager.getInstance();
                            await database.db.delete(
                              'seen_list_movie_entries',
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
                            if (formKey.currentState!.validate()){
                              formKey.currentState!.save();
                      
                              final database = SeenListDatabaseManager.getInstance();
                              await database.db.update(
                                'seen_list_movie_entries', 
                                {
                                  'title': movieEntryFields.title,
                                  'genre': movieEntryFields.genre,
                                  'date': movieEntryFields.date,
                                  'rating': movieEntryFields.rating
                                },
                                where: 'id = ?',
                                whereArgs: [movie.id]
                              );
                          
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          icon: const Icon(Icons.check_box),
                          label: const Text('Save Movie')
                        ),
                      ),
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