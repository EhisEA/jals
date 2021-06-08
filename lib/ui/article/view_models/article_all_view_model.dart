import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class ArticleAllViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleService _articleService = ArticleService();
  List<ArticleModel> articles;

  ArticleAllViewModel() {
    getArticles();
  }
  Future<void> getArticles() async {
    setBusy(ViewState.Busy);
    if (await _networkConfig.onNetworkAvailabilityBool())
      await getArticlesNewtworkCall();
    setBusy(ViewState.Idle);
  }

  getArticlesNewtworkCall() async {
    articles = await _articleService.getArticles();
  }
}
