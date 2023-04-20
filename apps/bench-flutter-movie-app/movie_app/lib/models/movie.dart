import 'package:flutter/material.dart';

@immutable
class Movie {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String imageUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.imageUrl,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['original_title'] ?? "",
      overview: json['overview'] ?? "",
      releaseDate: json['release_date'] ?? "",
      imageUrl: json['poster_path']?.isNotEmpty
          ? "https://image.tmdb.org/t/p/w500/${json['poster_path']}"
          : "",
    );
  }
}
