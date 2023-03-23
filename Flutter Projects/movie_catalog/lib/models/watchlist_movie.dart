class WatchlistMovie {
  final int? id;
  final String title;
  final String genre;
  final String date;

  const WatchlistMovie({
    required this.id,
    required this.title,
    required this.genre,
    required this.date
  });

  factory WatchlistMovie.fromMap(Map<String, dynamic> json) => WatchlistMovie(
    id: json['id'],
    title: json['title'],
    genre: json['genre'],
    date: json['date']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'date': date
    };
  }
}