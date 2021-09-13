import 'dart:async';

import 'package:movies_app_tmdb/src/resources/movie_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';

class MovieDetailBloc {
  final _repository = MoviesRepository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer((
      Future<TrailerModel> trailer,
      int id,
      int index,
    ) {
      print(index);
      trailer = _repository.fetchTrailers(id);
      return trailer;
    }, emptyFutureTrailerModel());
  }

  Future<TrailerModel> emptyFutureTrailerModel() async {
    return TrailerModel(
        totalResults: 0, page: 0, results: List.empty(), totalPages: 0);
  }
}
