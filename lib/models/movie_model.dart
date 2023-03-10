import 'package:movies/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.genreIds,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((e) => e)),
        overview: json['overview'],
        // TODO : check this
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
      );
}

class DummyMovies {
  List<MovieModel> dummyMovies = [
    MovieModel(
      id: 1,
      title: "title",
      backdropPath:
          'https://www.gardendesign.com/pictures/images/675x529Max/site_3/helianthus-yellow-flower-pixabay_11863.jpg',
      genreIds: [1],
      overview: "overview",
      voteAverage: 8.5,
      releaseDate: 'releaseDate',
    ),
    MovieModel(
      id: 1,
      title: "title",
      backdropPath:

          'https://www.gardendesign.com/pictures/images/675x529Max/site_3/helianthus-yellow-flower-pixabay_11863.jpg',
      genreIds: [1],
      overview: "overview",
      voteAverage: 8.5,
      releaseDate: 'releaseDate',
    ),
    MovieModel(
      id: 1,
      title: "title",
      backdropPath:
          'https://www.gardendesign.com/pictures/images/675x529Max/site_3/helianthus-yellow-flower-pixabay_11863.jpg',
      genreIds: [1],
      overview: "overview",
      voteAverage: 8.5,
      releaseDate: 'releaseDate',
    ),
  ];
}
