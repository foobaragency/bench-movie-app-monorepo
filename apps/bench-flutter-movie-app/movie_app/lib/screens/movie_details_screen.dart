import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_cast_list.dart';
import 'package:movie_app/widgets/movie_list_item.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String title;
  final int id;

  const MovieDetailsScreen({super.key, required this.title, required this.id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Movie> movie;

  @override
  void initState() {
    super.initState();
    movie = movieApi.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Movie>(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      color: Colors.blueAccent,
                      child: MovieListItem(
                        title: snapshot.data?.title ?? "",
                        releaseDate: snapshot.data?.releaseDate ?? "",
                        posterImage: snapshot.data?.imageUrl ?? "",
                      ),
                    ),
                  ),
                  Text(snapshot.data?.overview ?? ""),
                  MovieCastList(movieId: widget.id)
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
