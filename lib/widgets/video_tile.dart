import 'package:flutter/material.dart';
import 'package:jals/constants/dummy_image.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image_loader.dart';

import '../route_paths.dart';
import 'image.dart';

class VideoTile extends StatelessWidget {
  final VideoModel videoModel;
  final bool showPrimaryButton, showSecondaryButton;
  final List<String> popOption;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();

  VideoTile({
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
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextCaption(
                    text: "${videoModel.author}",
                  ),
                  Spacer(),
                  // Row to be disappear if item has been purchased
                  //TODO: remove helper
                  videoModel.isPurchased ?? true
                      ? Container()
                      : Row(
                          children: [
                            showSecondaryButton
                                ? ClipOval(
                                    child: Container(
                                      color: kGreen.withOpacity(0.15),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: videoModel.price <= 0
                                            ? Colors.blue
                                            : kGreen,
                                        size: getProportionatefontSize(15),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Spacer(),
                            showPrimaryButton
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: videoModel.price <= 0
                                          ? Colors.blue
                                          : kGreen,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionatefontSize(20),
                                      vertical: getProportionatefontSize(2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        videoModel.price <= 0 ? "Free" : "Buy",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                getProportionatefontSize(12)),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                  SizedBox(
                    height: getProportionatefontSize(5),
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

class VideoTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(100),
          width: getProportionatefontSize(100),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 10,
              width: 100,
              child: ImageShimmerLoadingStateLight(),
            ),
          ),
        ),
        SizedBox(
          width: getProportionatefontSize(20),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2),
            height: getProportionatefontSize(100),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  // width: 150,
                  child: ImageShimmerLoadingStateLight(),
                ),
                SizedBox(
                  height: getProportionatefontSize(10),
                ),
                Container(
                  height: 10,
                  width: 100,
                  child: ImageShimmerLoadingStateLight(),
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                Spacer(),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
