import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/layout/movie_app_scaffold.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/screens/movie_details_screen.dart';

class HomeScreen extends HookConsumerWidget {
  final String title;

  const HomeScreen({super.key, this.title = "Home Screen"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(moviesListProvider.notifier).fetchNowPlayingMovies();
      });
    }, []);

    final asyncMovieListPage = ref.watch(moviesListProvider);

    return MovieAppScaffold(
      title: title,
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
      showsCategoryDrawer: true,
    );
  }
}
