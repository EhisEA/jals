import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class ArticleBookMarkedViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleService _articleService = ArticleService();
  List<ArticleModel> articles;
  getArticles() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(getArticlesNewtworkCall);
    setBusy(ViewState.Idle);
  }

  getArticlesNewtworkCall() async {
    articles = await _articleService.getBookmakedArticles();
  }
}
