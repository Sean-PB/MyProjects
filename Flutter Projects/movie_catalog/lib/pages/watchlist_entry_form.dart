import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_catalog/db/database_managers.dart';
import '../db/movie_entry_dto.dart';

class WatchlistEntryForm extends StatefulWidget {
  const WatchlistEntryForm({super.key});

  static const routeName = 'WatchlistUpdate';

  @override
  State<WatchlistEntryForm> createState() => _WatchlistEntryForm();
}

class _WatchlistEntryForm extends State<WatchlistEntryForm> {

  final formKey = GlobalKey<FormState>();
  final movieEntryFields = WatchlistMovieEntryFields();
  final TextEditingController _dateField = TextEditingController();
  late DateTime _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Movie to Watchlist'),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
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
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
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
                      DateTime? date = await showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.utc(1888, 8, 14),
                      lastDate: DateTime(2100)
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
                              formKey.currentState!.save();
                              final databaseManger = WatchlistDatabaseManager.getInstance();
                              databaseManger.saveMovieEntry(dto: movieEntryFields);               
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Save Movie')
                        ),
                      )
                    ]
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