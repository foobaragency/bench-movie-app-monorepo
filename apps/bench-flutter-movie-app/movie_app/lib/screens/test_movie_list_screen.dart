import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/layout/movie_app_scaffold.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/screens/movie_details_screen.dart';

class TestMovieListScreen extends HookConsumerWidget {
  const TestMovieListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieListPage = ref.watch(moviesListProvider);

    return MovieAppScaffold(
      title: "Test Movie List Screen",
      body: asyncMovieListPage.when(
        data: (data) => ListView.builder(
          itemCount: data.movies.length,
          itemBuilder: (context, index) {
            final movie = data.movies[index];

            return ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.releaseDate),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailsScreen(title: movie.title),
                  ),
                );
              },
            );
          },
        ),
        error: (error, stackTrace) => Center(
          child: Text("Error loading $error"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
