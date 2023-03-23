import 'database_managers.dart';
import '../models/watchlist_movie.dart';
import '../models/seen_list_movie.dart';

class WatchlistMovieDAO {
  static Future<List<WatchlistMovie>> movieEntries({required WatchlistDatabaseManager databaseManager}) async {
    final movieRecords = await databaseManager.movieEntries();
    return movieRecords.map( (record) {
      return WatchlistMovie(
        id: record['id'],
        title: record['title'], 
        genre: record['genre'], 
        date: record['date']);
    }).toList();
  }
}

class SeenListMovieDAO {
  static Future<List<SeenListMovie>> movieEntries({required SeenListDatabaseManager databaseManager}) async {
    final movieRecords = await databaseManager.movieEntries();
    return movieRecords.map( (record) {
      return SeenListMovie(
        id: record['id'],
        title: record['title'], 
        genre: record['genre'], 
        rating: record['rating'],
        date: record['date']);
    }).toList();
  }
}