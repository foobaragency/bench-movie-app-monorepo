import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:movie_app/models/movie_list_page.dart';
import 'package:http/http.dart' as http;

import '../enums/movie_enums.dart';

MovieListPage _parseMovieListPageFromResponse(Response response) {
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<String, dynamic>();

    return MovieListPage.fromJson(parsed);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to fetch movies');
  }
}

class MovieListNotifier extends AsyncNotifier<MovieListPage> {
  final _movieApiUrl = dotenv.env['MOVIE_API_URL'];
  final _movieApiKey = dotenv.env['MOVIE_API_KEY'];

  Future<void> fetchMovies(MovieListType movieListType) async {
    const movieListTypeMap = {
      MovieListType.nowPlaying: 'now_playing',
      MovieListType.popular: 'popular',
      MovieListType.topRated: 'top_rated',
      MovieListType.upcoming: 'upcoming,'
    };

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await http.get(Uri.parse(
        '$_movieApiUrl/movie/${movieListTypeMap[movieListType]}?api_key=$_movieApiKey&language=en-US',
      ));
      return _parseMovieListPageFromResponse(response);
    });
  }

  Future<void> fetchNowPlayingMovies() async {
    await fetchMovies(MovieListType.nowPlaying);
  }

  Future<void> fetchUpcomingMovies() async {
    await fetchMovies(MovieListType.upcoming);
  }

  Future<void> fetchTopRatedMovies() async {
    await fetchMovies(MovieListType.topRated);
  }

  Future<void> fetchPopularMovies() async {
    await fetchMovies(MovieListType.popular);
  }

  @override
  MovieListPage build() {
    return const MovieListPage(
      pageNum: 0,
      totalPages: 0,
      totalResults: 0,
      movies: [],
    );
  }
}

final moviesListProvider =
    AsyncNotifierProvider<MovieListNotifier, MovieListPage>(() {
  return MovieListNotifier();
});
