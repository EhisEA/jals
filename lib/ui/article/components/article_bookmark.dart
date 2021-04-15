import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_bookmarked_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class ArticleBookmark extends StatefulWidget {
  @override
  _ArticleBookmarkState createState() => _ArticleBookmarkState();
}

class _ArticleBookmarkState extends State<ArticleBookmark>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ArticleBookMarkedViewModel>.reactive(
      onModelReady: (model) => model.getArticles(),
      builder: (context, model, _) {
        return model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.articles == null
                ? Retry(
                    onRetry: model.getArticles,
                  )
                : model.articles.isEmpty
                    ? Empty(
                        title: "No Bookmarked Article",
                      )
                    : RefreshIndicator(
                        onRefresh: model.getArticles,
                        child: ListView(
                          children: List.generate(
                            model.articles.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child:
                                  ArticleTile(article: model.articles[index]),
                            ),
                          ),
                        ),
                      );
      },
      viewModelBuilder: () => locator<ArticleBookMarkedViewModel>(),
      disposeViewModel: false,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
