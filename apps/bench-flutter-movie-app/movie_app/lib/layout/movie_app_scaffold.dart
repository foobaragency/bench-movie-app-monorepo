import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_category_drawer.dart';

class MovieAppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showsCategoryDrawer;

  const MovieAppScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.showsCategoryDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      drawer: showsCategoryDrawer ? const MovieCategoryDrawer() : null,
    );
  }
}
