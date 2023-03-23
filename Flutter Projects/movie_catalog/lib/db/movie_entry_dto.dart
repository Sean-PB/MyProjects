class WatchlistMovieEntryFields {
  late int id;
  late String title;
  String genre = '';
  String date = '';

  @override
  String toString() {
    return 'Title: $title, Genre: $genre, Release Date: $date';
  }
}

class SeenListMovieEntryFields {
  late int id;
  late String title;
  String genre = '';
  int rating = 0;
  String date = '';

  @override
  String toString() {
    return 'Title: $title, Genre: $genre, Rating: $rating Release Date: $date';
  }
}