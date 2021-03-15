import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class ArticleNewsViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleService _articleService = ArticleService();
  List<ArticleModel> news;
  getArticles() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(getArticlesNewtworkCall);
    setBusy(ViewState.Idle);
  }

  getArticlesNewtworkCall() async {
    news = await _articleService.getNews();
  }
}
