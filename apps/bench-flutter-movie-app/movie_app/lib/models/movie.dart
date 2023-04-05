import 'package:flutter/material.dart';

@immutable
class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String imageUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.imageUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['original_title'] ?? "",
      releaseDate: json['release_date'] ?? "",
      imageUrl: json['poster_path']?.isNotEmpty
          ? "https://image.tmdb.org/t/p/w500/${json['poster_path']}"
          : "",
    );
  }
}
