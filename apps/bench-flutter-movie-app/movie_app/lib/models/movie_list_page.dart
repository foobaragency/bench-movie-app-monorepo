import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

@immutable
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
