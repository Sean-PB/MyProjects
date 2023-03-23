import 'package:flutter/material.dart';
import 'app.dart';
import 'db/database_managers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WatchlistDatabaseManager.initialize();
  await SeenListDatabaseManager.initialize();
  runApp(App());
}

