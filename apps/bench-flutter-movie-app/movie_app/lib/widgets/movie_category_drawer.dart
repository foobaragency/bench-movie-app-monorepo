import 'package:flutter/material.dart';
import 'package:movie_app/screens/test_movie_list_screen.dart';

class MovieCategoryDrawer extends StatelessWidget {
  const MovieCategoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Movie Categories'),
          ),
          ListTile(
            title: const Text('Test Movie List Screen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TestMovieListScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
