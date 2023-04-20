import 'package:flutter/material.dart';

@immutable
class MovieActor {
  final String name;
  final String characterName;
  final String imageUrl;

  const MovieActor({
    required this.name,
    required this.characterName,
    required this.imageUrl,
  });

  factory MovieActor.fromJson(Map<String, dynamic> json) {
    return MovieActor(
      name: json['name'],
      characterName: json['character'],
      imageUrl: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500/${json['profile_path']}"
          : "",
    );
  }
}
