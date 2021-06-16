import 'package:flutter/material.dart';
import 'package:jals/constants/dummy_image.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';

import '../route_paths.dart';

class DownloadingVideoTile extends StatelessWidget {
  final VideoModel videoModel;
  final bool showPrimaryButton, showSecondaryButton;
  final List<String> popOption;
  final double progress;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();

  DownloadingVideoTile({
    Key key,
    @required this.videoModel,
    this.showPrimaryButton = true,
    this.showSecondaryButton = true,
    this.popOption,
    this.onOptionSelect,
    @required this.progress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        if (videoModel.price > 0 && !videoModel.isPurchased) {
          _navigationService.navigateTo(StoreItemViewRoute,
              argument: videoModel.toContent());
        } else {
          _navigationService.navigateTo(VideoPlayerViewRoute,
              argument: videoModel);
        }
      },
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(100),
            width: getProportionatefontSize(100),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(
                  imageUrl: videoModel.coverImage ?? dummyImage),
            ),
          ),
          SizedBox(
            width: getProportionatefontSize(20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              height: getProportionatefontSize(110),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            TextTitle(
                              maxLines: 2,
                              text: "${videoModel.title}",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextCaption(
                              text: "${videoModel.author}",
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 20,
                            // color: Colors.red,
                            child: PopupMenuButton(
                              padding: EdgeInsets.all(0),

                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              // color: kScaffoldColor,
                              onSelected: (value) => onOptionSelect(value),
                              // onSelected: (value) => model.showReportDialog(context),
                              itemBuilder: (BuildContext context) =>
                                  List.generate(
                                popOption.length,
                                (index) => PopupMenuItem(
                                  value: "${popOption[index]}",
                                  child: Text("${popOption[index]}"),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 30,
                                    padding: EdgeInsets.only(right: 10),
                                    child: CircularProgressIndicator(
                                      value: progress / 100,
                                      semanticsLabel:
                                          "pp", //progress.toString(),
                                      backgroundColor: kPrimaryColor.shade200,
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: Text("${progress.floor()} %"),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
