import 'package:jals/models/article_model.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class ArticleDownloadViewModel extends BaseViewModel {
  final _hiveDatabaseService = locator<HiveDatabaseService>();

  List<ArticleModel> articles;
  getArticles() async {
    setBusy(ViewState.Busy);
    try {
      articles = _hiveDatabaseService.getDownloadedArticle();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }
}
