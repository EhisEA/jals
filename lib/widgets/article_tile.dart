import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/constants/dummy_image.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/models/video_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/image_loader.dart';
import 'package:jiffy/jiffy.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;

  const ArticleTile({
    Key key,
    @required this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: InkWell(
        onTap: () {
          NavigationService _navigationService = locator<NavigationService>();
          _navigationService.navigateTo(ArticleViewRoute, argument: article);
        },
        child: Row(
          children: [
            Container(
              height: getProportionatefontSize(80),
              width: getProportionatefontSize(80),
              child: AspectRatio(
                aspectRatio: 1,
                child: ShowNetworkImage(imageUrl: article.coverImage),
              ),
            ),
            Expanded(
              child: ListTile(
                title: TextTitle(
                  text: "${article.title}",
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 5),
                        child: TextCaption(
                          text: article.downloadDate != null
                              ? "Downloaded ${DateFormat("dd/MM/yyyy").format(article.downloadDate)}"
                              : "${article.author}",
                        ),
                      ),
                    ),
                    article.isBookmarked == null || article.downloaded
                        ? SizedBox()
                        : article.isBookmarked
                            ? Icon(
                                Icons.bookmark,
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AudioTile extends StatelessWidget {
  final AudioModel audio;
  final List<String> popOption;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();
  AudioTile(
      {Key key, this.audio, this.popOption: const [], this.onOptionSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        _navigationService.navigateTo(AudioPlayerViewRoute, argument: {
          "audios": [audio],
          "playlistName": null
        });
      },
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(60),
            width: getProportionatefontSize(60),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(imageUrl: audio.coverImage),
            ),
          ),
          Expanded(
            child: ListTile(
              title: TextTitle(
                text: "${audio.title}",
                maxLines: 2,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: TextCaption(
                  text: "${audio.author}",
                ),
              ),
              trailing: PopupMenuButton(
                padding: EdgeInsets.all(0),

                icon: Icon(
                  Icons.more_vert,
                  // color: Colors.,
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
          ),
        ],
      ),
    );
  }
}

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
        if (videoModel.price > 0) {
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
                  videoModel.isPurchased
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

class ProductTile extends StatelessWidget {
  final String image, title, author, type;

  const ProductTile(
      {Key key,
      @required this.image,
      @required this.title,
      this.author = "",
      @required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        Container(
          height: getProportionatefontSize(80),
          width: getProportionatefontSize(80),
          child: AspectRatio(
            aspectRatio: 1,
            child: ShowNetworkImage(imageUrl: image),
          ),
        ),
        SizedBox(
          width: getProportionatefontSize(20),
        ),
        Expanded(
          child: Container(
            height: getProportionatefontSize(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCaption(
                  text: "$type",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextTitle(
                  maxLines: 1,
                  text: "$title+",
                ),
                SizedBox(
                  height: getProportionatefontSize(5),
                ),
                TextCaption(
                  text: "$author",
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

class StoreTile extends StatelessWidget {
  final ContentModel content;

  const StoreTile({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: InkWell(
        onTap: () => locator<NavigationService>()
            .navigateTo(StoreItemViewRoute, argument: content),
        child: Row(
          children: [
            Container(
              height: getProportionatefontSize(80),
              width: getProportionatefontSize(80),
              child: AspectRatio(
                aspectRatio: 1,
                child: ShowNetworkImage(imageUrl: content.coverImage),
              ),
            ),
            SizedBox(
              width: getProportionatefontSize(20),
            ),
            Expanded(
              child: Container(
                height: getProportionatefontSize(80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCaption(
                      text: Jiffy(content.createdAt).format('do MMMM, yyyy'),
                    ),
                    SizedBox(
                      height: getProportionatefontSize(5),
                    ),
                    TextTitle(
                      maxLines: 1,
                      text: "${content.title}",
                    ),
                    SizedBox(
                      height: getProportionatefontSize(5),
                    ),
                    Text.rich(
                      TextSpan(
                        text: getTypeString() + " . ",
                        style: TextStyle(
                          color: Color(0xff1F2230).withOpacity(0.8),
                        ),
                        children: [
                          TextSpan(
                            text: content.price <= 0
                                ? "Free"
                                : "${content.price} Credits",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  String getTypeString() {
    switch (content.postType) {
      case ContentType.Audio:
        return "Audio";
      case ContentType.Article:
        return "Article";
      case ContentType.News:
        return "News";
      case ContentType.Video:
        return "Video";
    }
  }
}

class LibraryForYouTile extends StatelessWidget {
  final ContentModel content;

  const LibraryForYouTile({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(80),
            width: getProportionatefontSize(80),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(imageUrl: content.coverImage),
            ),
          ),
          SizedBox(
            width: getProportionatefontSize(20),
          ),
          Expanded(
            child: Container(
              height: getProportionatefontSize(80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCaption(
                    text: getTypeString(),
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextTitle(
                    maxLines: 1,
                    text: content.title,
                  ),
                  SizedBox(
                    height: getProportionatefontSize(5),
                  ),
                  TextCaption(
                    text: content.price <= 0
                        ? "Free"
                        : "${content.price} Credits",
                  ),
                  // TextCaption(
                  //   text: getTypeString(),
                  // ),
                  // Text.rich(
                  //   TextSpan(
                  //     text: getTypeString() + " . ",
                  //     style: TextStyle(
                  //       color: Color(0xff1F2230).withOpacity(0.8),
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: content.price <= 0
                  //             ? "Free"
                  //             : "${content.price} Credits",
                  //         style: TextStyle(
                  //           color: kPrimaryColor,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  String getTypeString() {
    switch (content.postType) {
      case ContentType.Audio:
        return "Audio";
      case ContentType.Article:
        return "Article";
      case ContentType.News:
        return "News";
      case ContentType.Video:
        return "Video";
    }
  }
}
