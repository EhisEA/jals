import 'package:flutter/material.dart';
import 'package:jals/ui/article/view_models/article_news_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/button.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';

class BuildNews extends StatefulWidget {
  final ArticleNewsViewModel articleNewsViewModel;
  const BuildNews({Key key, @required this.articleNewsViewModel})
      : super(key: key);
  @override
  _BuildNewsState createState() => _BuildNewsState();
}

class _BuildNewsState extends State<BuildNews>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ArticleNewsViewModel>.reactive(
      // onModelReady: (model) => model.getArticles(),
      viewModelBuilder: () => widget.articleNewsViewModel,
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
            : model.news == null
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        DefaultButton(
                          color: Colors.grey.shade400,
                          onPressed: model.getNews,
                          title: "Retry",
                        ),
                      ],
                    ),
                  )
                : SliverClip(
                    child: SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          model.news.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ArticleTile(
                              article: model.news[index],
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
