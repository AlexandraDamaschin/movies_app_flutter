import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:movies_app_tmdb/src/models/movie_model.dart';
import 'dart:convert';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = 'af491e18f1d0a6e2955cf1fecc579c1d';

  Future<MovieModel> fetchMovieList() async {
    final response = await client.get(Uri.parse(
        "http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
