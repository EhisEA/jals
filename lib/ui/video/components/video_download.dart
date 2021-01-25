import 'package:flutter/material.dart';
import 'package:jals/widgets/article_tile.dart';

class VideoDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: VideoTile(
            image:
                "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
            title: "How to Pray and Communicate with God",
            author: "Download 2020/30/03",
            showPrimaryButton: false,
            showSecondaryButton: false,
          ),
        ),
      ),
    );
  }
}
