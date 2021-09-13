import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:movies_app_tmdb/src/models/movie_model.dart';
import 'dart:convert';

import 'package:movies_app_tmdb/src/models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = 'af491e18f1d0a6e2955cf1fecc579c1d';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MovieModel> fetchMovieList() async {
    final response =
        await client.get(Uri.parse("$_baseUrl/popular?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client
        .get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey"));

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
