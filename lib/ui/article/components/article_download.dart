import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_download_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class ArticleDownload extends StatefulWidget {
  @override
  _ArticleDownloadState createState() => _ArticleDownloadState();
}

class _ArticleDownloadState extends State<ArticleDownload>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ArticleDownloadViewModel>.reactive(
      viewModelBuilder: () => locator<ArticleDownloadViewModel>(),
      disposeViewModel: false,
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
                        title: "No Downloaded Article",
                      )
                    : ListView(
                        children: List.generate(
                          model.articles.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ArticleTile(article: model.articles[index]),
                          ),
                        ),
                      );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
