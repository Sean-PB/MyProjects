class SeenListMovie {
  final int? id;
  final String title;
  final String genre;
  final String date;
  final int rating;

  const SeenListMovie({
    required this.id,
    required this.title,
    required this.genre,
    required this.date,
    required this.rating
  });

  factory SeenListMovie.fromMap(Map<String, dynamic> json) => SeenListMovie(
    id: json['id'],
    title: json['title'],
    genre: json['genre'],
    date: json['date'],
    rating: json['rating']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'date': date,
      'rating': rating
    };
  }
}