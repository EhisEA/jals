import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/ui/article/view_models/article_view_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/image.dart';
import 'package:stacked/stacked.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel article;
  final ScrollController _scrollController = ScrollController();

  ArticleView({Key key, @required this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<ArticleViewViewModel>.reactive(
        viewModelBuilder: () => ArticleViewViewModel(),
        onModelReady: (model) => model.getArticleDetails(article),
        builder: (context, model, _) {
          return Scaffold(
            bottomNavigationBar: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.keyboard_arrow_up),
                        Text(
                          "Scroll Up",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  InkWell(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.keyboard_arrow_down),
                        Text(
                          "Scroll Down",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: Padding(
                  padding: const EdgeInsets.all(10.0), child: BackIcon()),
              actions: [
                model.article == null
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 1000),
                          opacity: model.article.downloaded ? 0 : 1,
                          child: InkWell(
                            onTap: model.toggleBookmark,
                            child: model.article.isBookmarked
                                ? Icon(Icons.bookmark, color: kPrimaryColor)
                                : Icon(
                                    Icons.bookmark_outline,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.share_outlined,
                    color: Colors.black,
                  ),
                ),
                model.article == null
                    ? SizedBox()
                    : model.article.downloaded
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 24,
                              width: 22,
                              // color: Colors.amber,
                              child: Stack(children: [
                                AnimatedPositioned(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.bounceOut,
                                  top: model.downloadPosition,
                                  child: InkWell(
                                    onTap: model.deleteFromDownload,
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                        : SizedBox(),
                model.article == null
                    ? SizedBox()
                    : model.article.downloaded
                        ? SizedBox()
                        : model.downloaded == null
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 24,
                                  width: 22,
                                  // color: Colors.amber,
                                  child: Stack(children: [
                                    AnimatedPositioned(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.bounceOut,
                                      top: model.downloadPosition,
                                      child: InkWell(
                                        onTap: model.download,
                                        child: Icon(
                                          CupertinoIcons.arrow_down_to_line_alt,
                                          color: model.downloaded
                                              ? kPrimaryColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  AspectRatio(
                    aspectRatio: 336 / 160,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: ShowNetworkImage(
                        imageUrl: article.coverImage,
                      ),
                      // "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png"),
                    ),
                  ),
                  SizedBox(height: 20),
                  // TextCaption(
                  //   text: "23rd December 2020",
                  // ),
                  TextCaption(
                    text:
                        "${DateFormat('dd MMMM yyyy').format(article.createdAt)}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextHeader(
                    text: article.title,
                    // "How to read, understand and decipher the teachings of Christ",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextCaption(
                    text: article.author,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  model.isBusy
                      ? Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            SpinKitRipple(
                              color: kPrimaryColor,
                              size: 100,
                              // borderWidth: 10,
                            ),
                          ],
                        )
                      : model.article == null
                          ? Column(
                              children: [
                                SizedBox(height: 30),
                                Icon(
                                  Icons.refresh,
                                  size: 40,
                                ),
                              ],
                            )
                          : TextArticle(
                              text: model.article.content,
                            ),
                ],
              ),
            ),
          );
        });
  }
}
