import 'package:flutter/material.dart';
import 'dart:async';
import 'package:movie_app/api/movie_api.dart';
import 'package:movie_app/models/movie_actor.dart';

class MovieCastList extends StatefulWidget {
  final int movieId;

  const MovieCastList({super.key, required this.movieId});

  @override
  State<MovieCastList> createState() => _MovieCastListState();
}

class _MovieCastListState extends State<MovieCastList> {
  late Future<List<MovieActor>> movieActors;

  @override
  void initState() {
    super.initState();
    movieActors = movieApi.getMovieCastById(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieActor>>(
      future: movieActors,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieActor> movieActorsList = snapshot.data ?? [];

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieActorsList.length,
              itemBuilder: (context, index) {
                final String actorImage = movieActorsList[index].imageUrl;
                final String actorName = movieActorsList[index].name;

                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: actorImage.isNotEmpty
                              ? Image.network(actorImage)
                              : const Text("No Image"),
                        ),
                        Text(
                          actorName,
                          style: const TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
