import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_all_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

class VideoAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoAllViewModel>.reactive(
      onModelReady: (model) => model.getAllVideos(),
      disposeViewModel: false,
      viewModelBuilder: () => VideoAllViewModel(),
      builder: (context, model, child) {
        return Stack(
          children: [
            model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: List.generate(
                      model.allVideoList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: VideoTile(
                          videoModel: model.allVideoList[index],
                          // image:
                          //     "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
                          // title: "How to Pray and Communicate with God",
                          // author: "Wade Warren",
                        ),
                      ),
                    ),
                  ),
            model.hasError
                ? Align(
                    alignment: Alignment.center,
                    child: DefaultButton(
                      color: Colors.blue,
                      onPressed: () => model.getAllVideos(),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
