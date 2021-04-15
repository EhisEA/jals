import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/utils/base_view_model.dart';

class ArticleBookMarkedViewModel extends BaseViewModel {
  ArticleService _articleService = ArticleService();
  List<ArticleModel> articles;
  Future<void> getArticles() async {
    setBusy(ViewState.Busy);
    await getArticlesNewtworkCall();
    setBusy(ViewState.Idle);
  }

  getArticlesNewtworkCall() async {
    articles = await _articleService.getBookmakedArticles();
  }
}
