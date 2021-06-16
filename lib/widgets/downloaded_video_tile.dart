import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';

import '../route_paths.dart';

class DownloadedVideoTile extends StatelessWidget {
  final VideoModel videoModel;
  final bool showPrimaryButton, showSecondaryButton;
  final List<String> popOption;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();

  DownloadedVideoTile({
    Key key,
    @required this.videoModel,
    this.showPrimaryButton = true,
    this.showSecondaryButton = true,
    this.popOption,
    this.onOptionSelect,
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
              child: ShowNetworkImage(imageUrl: videoModel.coverImage),
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
                  // Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextTitle(
                          maxLines: 2,
                          text: "${videoModel.title}",
                        ),
                      ),
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
                          itemBuilder: (BuildContext context) => List.generate(
                            popOption.length,
                            (index) => PopupMenuItem(
                              value: "${popOption[index]}",
                              child: Text("${popOption[index]}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  TextCaption(
                    text: "${videoModel.author}",
                  ),
                  SizedBox(height: 10),
                  TextCaption(
                    text:
                        "Downloaded ${DateFormat(" dd/MM/yyyy").format(videoModel.downloadDate)}",
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
