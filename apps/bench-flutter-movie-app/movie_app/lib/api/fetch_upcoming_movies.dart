import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieListPage {
  final int pageNum;
  final int totalPages;
  final int totalResults;
  final List<Movie> movies;

  const MovieListPage({
    required this.pageNum,
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  factory MovieListPage.fromJson(Map<String, dynamic> json) {
    return MovieListPage(
      pageNum: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      movies: json['results']
          .map<Movie>((dynamic result) => Movie.fromJson(result))
          .toList(),
    );
  }
}

class Movie {
  final int id;
  final String title;

  const Movie({
    required this.id,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['original_title'],
    );
  }
}

MovieListPage _parseMovieListPage(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();

  return MovieListPage.fromJson(parsed);
}

Future fetchUpcomingMovies() async {
  final movieApiUrl = dotenv.env['MOVIE_API_URL'];
  final movieApiKey = dotenv.env['MOVIE_API_KEY'];
  final response = await http.get(Uri.parse(
      '$movieApiUrl/movie/upcoming?api_key=$movieApiKey&language=en-US'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return _parseMovieListPage(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
