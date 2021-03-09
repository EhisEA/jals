import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/all_video_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:stacked/stacked.dart';

class VideoAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllVideoViewModel>.reactive(
      viewModelBuilder: () => AllVideoViewModel(),
      builder: (context, model, _) {
        return ListView(
          children: List.generate(
            20,
            (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: VideoTileLoading()

                // VideoTile(
                //   image:
                //       "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
                //   title: "How to Pray and Communicate with God",
                //   author: "Wade Warren",
                // ),
                ),
          ),
        );
      },
    );
  }

  loadingState() {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: VideoTileLoading()
            //  VideoTile(
            //   image:
            //       "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
            //   title: "How to Pray and Communicate with God",
            //   author: "Wade Warren",
            // ),
            ),
      ),
    );
  }
}
