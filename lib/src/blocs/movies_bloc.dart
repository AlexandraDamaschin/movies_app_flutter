import 'package:movies_app_tmdb/src/models/movie_model.dart';
import 'package:movies_app_tmdb/src/resources/movie_repository.dart';

import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = MoviesRepository();
  final _moviesFetcher = PublishSubject<MovieModel>();

  Stream<MovieModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    MovieModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
