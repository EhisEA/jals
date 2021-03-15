import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_bookmarked_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

class ArticleBookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArticleBookMarkedViewModel>.reactive(
      onModelReady: (model) => model.getArticles(),
      builder: (context, model, _) {
        return model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.articles == null
                ? Center(
                    child: DefaultButton(
                      onPressed: model.getArticles,
                      title: "Retry",
                    ),
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
      viewModelBuilder: () => ArticleBookMarkedViewModel(),
    );
  }
}
