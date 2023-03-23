import 'package:flutter/material.dart';
import 'package:movie_app/layout/movie_app_scaffold.dart';
import 'package:movie_app/screens/movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieAppScaffold(
      title: 'Home Screen',
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MovieDetailsScreen(title: 'foobar the Movie')));
          },
        ),
      ),
      showsCategoryDrawer: true,
    );
  }
}
