import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class ArticleNewsViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleService _articleService = ArticleService();
  List<ArticleModel> news;
  ArticleNewsViewModel(){
    getNews();
  }
  getNews() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityToast(_getNewssNewtworkCall);
    setBusy(ViewState.Idle);
  }

  _getNewssNewtworkCall() async {
    news = await _articleService.getNews();
  }
}
