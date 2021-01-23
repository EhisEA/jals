import 'package:flutter/material.dart';
import 'package:jals/widgets/article_tile.dart';

class AudioAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AudioTile(
            image:
                "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
            title: "How to Pray and Communicate with God",
            author: "Lecrae - Restoration",
          ),
        ),
      ),
    );
  }
}
