import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'movie_entry_dto.dart';

class WatchlistDatabaseManager {

  static const SCHEMA_PATH = 'assets\\watchlist_schema_1.sql.txt';
  static const String DATABASE_FILENAME = 'watchlist.db';
  static const String SQL_INSERT = 'INSERT INTO watchlist_movie_entries(title, genre, date) VALUES(?, ?, ?)';
  static const String SQL_SELECT = 'SELECT * FROM watchlist_movie_entries';

  static late WatchlistDatabaseManager _instance;

  late final Database db;

  WatchlistDatabaseManager._({required Database database}) : db = database;

  factory WatchlistDatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final db = await openDatabase(
      DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, await rootBundle.loadString(SCHEMA_PATH));
      } 
    );
    _instance = WatchlistDatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveMovieEntry({required WatchlistMovieEntryFields dto}) {
    db.transaction( (txn) async {
      await txn.rawInsert(
        SQL_INSERT,
        [dto.title, dto.genre, dto.date]
      );
    });
  }

  Future<List<Map<String, dynamic>>> movieEntries() async {
    // await deleteDatabase(DATABASE_FILENAME); // DELETE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    return db.rawQuery(SQL_SELECT);
  }
}

class SeenListDatabaseManager {

  static const SCHEMA_PATH = 'assets\\seen_list_schema_1.sql.txt';

  static const String DATABASE_FILENAME = 'seen_list.db';
  static const String SQL_INSERT = 'INSERT INTO seen_list_movie_entries(title, genre, rating, date) VALUES(?, ?, ?, ?)';
  static const String SQL_SELECT = 'SELECT * FROM seen_list_movie_entries';

  static late SeenListDatabaseManager _instance;

  late final Database db;

  SeenListDatabaseManager._({required Database database}) : db = database;

  factory SeenListDatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }

  static Future initialize() async {
    final db = await openDatabase(
      DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, await rootBundle.loadString(SCHEMA_PATH));
      } 
    );
    _instance = SeenListDatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveMovieEntry({required SeenListMovieEntryFields dto}) {
    print(dto);
    db.transaction( (txn) async {
      await txn.rawInsert(
        SQL_INSERT,
        [dto.title, dto.genre, dto.rating, dto.date]
      );
    });
  }

  Future<List<Map<String, dynamic>>> movieEntries() async {
    // await deleteDatabase(DATABASE_FILENAME); // DELETE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    return db.rawQuery(SQL_SELECT);
  }
}