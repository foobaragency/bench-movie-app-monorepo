import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_app/enums/movie_enums.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_actor.dart';
import 'package:movie_app/models/movie_list_page.dart';

class MovieAPI {
  final _movieApiUrl = dotenv.env['MOVIE_API_URL'];
  final _movieApiKey = dotenv.env['MOVIE_API_KEY'];

  Future<MovieListPage> getMoviePageByType(MovieListType movieListType) async {
    const movieListTypeMap = {
      MovieListType.nowPlaying: 'now_playing',
      MovieListType.popular: 'popular',
      MovieListType.topRated: 'top_rated',
      MovieListType.upcoming: 'upcoming,'
    };

    Response response = await http.get(Uri.parse(
      '$_movieApiUrl/movie/${movieListTypeMap[movieListType]}?api_key=$_movieApiKey&language=en-US',
    ));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<String, dynamic>();

      return MovieListPage.fromJson(parsed);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch movies');
    }
  }

  Future<Movie> getMovieById(int id) async {
    Response response = await http.get(Uri.parse(
      '$_movieApiUrl/movie/$id?api_key=$_movieApiKey&language=en-US',
    ));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<String, dynamic>();

      return Movie.fromJson(parsed);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch movies');
    }
  }

  Future<List<MovieActor>> getMovieCastById(int id) async {
    Response response = await http.get(Uri.parse(
      '$_movieApiUrl/movie/$id/credits?api_key=$_movieApiKey&language=en-US',
    ));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<String, dynamic>();

      return parsed['cast']
          .map<MovieActor>((dynamic result) => MovieActor.fromJson(result))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch movies');
    }
  }
}

MovieAPI movieApi = MovieAPI();
