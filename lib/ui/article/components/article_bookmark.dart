import 'package:flutter/material.dart';
import 'package:jals/widgets/article_tile.dart';

class ArticleBookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ArticleTile(
            image:
                "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg",
            title:
                "How to read, understand and decipher the teachings of Christ",
            author: "Esther Howard",
            isBookmark: true,
          ),
        ),
      ),
    );
  }
}
