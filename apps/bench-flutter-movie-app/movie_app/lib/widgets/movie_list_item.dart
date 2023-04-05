import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String posterImage;

  const MovieListItem({
    super.key,
    required this.title,
    required this.releaseDate,
    required this.posterImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.network(posterImage)),
          Expanded(
            flex: 1,
            child: Column(children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(releaseDate),
            ]),
          )
        ],
      ),
    );
  }
}
