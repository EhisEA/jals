import 'package:flutter/material.dart';
import 'package:jals/ui/article/components/build_articles.dart';
import 'package:jals/ui/article/components/build_news.dart';
import 'package:jals/ui/article/components/build_trending.dart';
import 'package:jals/ui/article/view_models/article_all_view_model.dart';
import 'package:jals/ui/article/view_models/article_news_view_model.dart';
import 'package:jals/ui/article/view_models/article_trending_view_model.dart';
import 'package:jals/ui/article/view_models/first_article_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleAll extends StatefulWidget {
  @override
  _ArticleAllState createState() => _ArticleAllState();
}

class _ArticleAllState extends State<ArticleAll> {
  int selected = 0;
  changeSelected(int index) {
    selected = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size defaultSize = MediaQuery.of(context).size;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return RefreshIndicator(
      onRefresh: () async {},
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ViewModelBuilder<FirstArticlViewModel>.reactive(
                viewModelBuilder: () => FirstArticlViewModel(),
                onModelReady: (model) => model.getArticle(),
                builder: (context, model, _) {
                  return AnimatedContainer(
                    curve: Curves.easeOut,
                    //Todo:  calculate the size value
                    height: model.article == null
                        ? 0
                        : (defaultSize.width / 160) *
                            (isPortrait ? 118 : 101), //300,
                    duration: Duration(milliseconds: 1500),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 3000),
                      child: model.article == null
                          ? SizedBox(
                              key: Key("44"),
                            )
                          : GestureDetector(
                              onTap: model.toArticle,
                              child: Column(
                                key: Key("77"),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 336 / 160,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      clipBehavior: Clip.hardEdge,
                                      child: ShowNetworkImage(
                                        imageUrl: model.article.coverImage,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextCaption(
                                    text:
                                        "${timeago.format(model.article.createdAt)}",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextHeader(
                                    maxLines: 2, text: "${model.article.title}",
                                    // "How to read, understand and deciphernderstand and deciphernderstand and deciphernderstand and decipher the teachings of Christ",
                                  ),
                                  TextCaption(
                                    text: "${model.article.author}",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                }),
          ),
          MultiSliver(
            children: [
              SliverPinnedHeader(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      category(title: "Article", index: 0),
                      category(title: "News", index: 1),
                      category(title: "Trending", index: 2),
                    ],
                  ),
                ),
              ),
              buildArticles(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildArticles() {
    switch (selected) {
      case 0:
        return BuildArticle(
          key: Key("0"),
          articleAllViewModel: locator<ArticleAllViewModel>(),
        );
      case 1:
        return BuildNews(
          key: Key("1"),
          articleNewsViewModel: locator<ArticleNewsViewModel>(),
        );

        break;
      case 2:
        return BuildTrendingArticle(
          key: Key("2"),
          articleTrendingViewModel: locator<ArticleTrendingViewModel>(),
        );

        break;
      default:
        return BuildArticle(
          key: Key("3"),
          articleAllViewModel: locator<ArticleAllViewModel>(),
        );
    }
  }

  category({
    @required String title,
    @required int index,
  }) {
    bool selected = this.selected == index;
    return Expanded(
      child: InkWell(
        onTap: () => changeSelected(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: selected ? kPrimaryColor : Colors.white,
            border: Border.all(
              color: selected ? kPrimaryColor : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: TextArticle(
              text: "$title",
              color: selected ? Colors.white : kTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
