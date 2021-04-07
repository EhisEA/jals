import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_all_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';

class BuildArticle extends StatefulWidget {
  const BuildArticle({Key key, @required this.articleAllViewModel}) : super(key: key);
  final ArticleAllViewModel articleAllViewModel;
  @override
  _BuildArticleState createState() => _BuildArticleState();
}

class _BuildArticleState extends State<BuildArticle>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ArticleAllViewModel>.reactive(
      // onModelReady: (model) => model.getArticles(),
      viewModelBuilder: () => widget.articleAllViewModel,
      disposeViewModel: false,
      builder: (context, model, _) {
        return model.isBusy
            ? SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : model.articles == null
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        DefaultButton(
                          onPressed: model.getArticles,
                          title: "Retry",
                        ),
                      ],
                    ),
                  )
                : SliverClip(
                    child: SliverList(
                      delegate: SliverChildListDelegate(List.generate(
                        model.articles.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ArticleTile(
                            article: model.articles[index],
                          ),
                        ),
                      )),
                    ),
                  );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
