import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/models/movie_list_page.dart';

import '../enums/movie_enums.dart';

class MovieListNotifier extends AsyncNotifier<MovieListPage> {
  Future<void> fetchMovies(MovieListType movieListType) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await movieApi.getMoviePageByType(movieListType);
      return response;
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
