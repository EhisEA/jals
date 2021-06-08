import 'package:jals/models/article_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class FirstArticlViewModel extends BaseViewModel {
  final ArticleService _articleService = ArticleService();
  final NavigationService _navigationService = locator<NavigationService>();
  ArticleModel article;

  getArticle() async {
    List<ArticleModel> articles = await _articleService.getArticlesList();
    if (articles != null) {
      if (articles.isNotEmpty) article = articles[0];
    }
    setBusy(ViewState.Idle);
  }

  toArticle() {
    _navigationService.navigateTo(
      ArticleViewRoute,
      argument: article,
    );
  }
}
