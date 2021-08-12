import 'dart:async';
import 'package:movies_app_tmdb/src/models/movie_model.dart';
import 'movie_api_provider.dart';

class MoviesRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<MovieModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
}
