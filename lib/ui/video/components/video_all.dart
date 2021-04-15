import 'package:flutter/material.dart';
import 'package:jals/ui/video/view_models/video_all_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class VideoAll extends StatefulWidget {
  @override
  _VideoAllState createState() => _VideoAllState();
}

class _VideoAllState extends State<VideoAll>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<VideoAllViewModel>.reactive(
      // onModelReady: (model) => model.getAllVideos(),
      disposeViewModel: false,
      viewModelBuilder: () => locator<VideoAllViewModel>(),
      builder: (context, model, child) {
        return Stack(
          children: [
            model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.allVideoList == null
                    ? Retry(
                        onRetry: model.getAllVideos,
                      )
                    : model.allVideoList.isEmpty
                        ? Empty(
                            title: "No video here",
                          )
                        : ListView(
                            children: List.generate(
                              model.allVideoList.length,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: VideoTile(
                                  videoModel: model.allVideoList[index],
                                  popOption: ["Share"],
                                  onOptionSelect: (value) =>
                                      model.onOptionSelect(
                                    value,
                                    model.allVideoList[index],
                                  ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
