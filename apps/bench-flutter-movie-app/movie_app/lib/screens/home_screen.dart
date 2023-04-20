import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/layout/movie_app_scaffold.dart';
import 'package:movie_app/providers/movie_list_provider.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/widgets/movie_list_item.dart';

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
        data: (data) => GridView.count(
          crossAxisCount: 2,
          children: data.movies.map<Widget>(
            (movie) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailsScreen(title: movie.title, id: movie.id),
                    ),
                  );
                },
                splashColor: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: MovieListItem(
                    title: movie.title,
                    releaseDate: movie.releaseDate,
                    posterImage: movie.imageUrl,
                  ),
                ),
              );
            },
          ).toList(),
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
