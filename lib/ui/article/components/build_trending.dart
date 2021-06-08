import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_trending_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';

class BuildTrendingArticle extends StatefulWidget {
  const BuildTrendingArticle({Key key, @required this.articleTrendingViewModel})
      : super(key: key);
  final ArticleTrendingViewModel articleTrendingViewModel;
  @override
  _BuildTrendingArticleState createState() => _BuildTrendingArticleState();
}

class _BuildTrendingArticleState extends State<BuildTrendingArticle>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ArticleTrendingViewModel>.reactive(
      onModelReady: (model) {
        if (!model.isBusy && model.articles == null) {
          model.getArticles();
        } else if (!model.isBusy && model.articles.isEmpty) {
          model.getArticles();
        }
      },
      viewModelBuilder: () => widget.articleTrendingViewModel,
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
                          color: Colors.grey.shade400,
                          onPressed: model.getArticles,
                          title: "Retry",
                        ),
                      ],
                    ),
                  )
                : SliverClip(
                    child: SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          model.articles.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ArticleTile(
                              article: model.articles[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
