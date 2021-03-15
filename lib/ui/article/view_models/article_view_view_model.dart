import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

import 'article_download_view_model.dart';

class ArticleViewViewModel extends BaseViewModel {
  final _hiveDatabaseService = locator<HiveDatabaseService>();
  final _articleDownloadViewModel = locator<ArticleDownloadViewModel>();
  ArticleService _articleService = ArticleService();
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleModel article;
  bool downloaded;
  double downloadPosition = 4;

  getArticleDetails(ArticleModel articleToView) async {
    setBusy(ViewState.Busy);
    if (articleToView.downloaded) {
      article = articleToView;
    } else {
      await _networkConfig.onNetworkAvailabilityDialog(
          () => getArticleDetailsNetworkCall(articleToView.id));
    }
    setBusy(ViewState.Idle);
  }

  getArticleDetailsNetworkCall(String id) async {
    article = await _articleService.getArticleDetails(id);
    if (article != null) {
      downloaded = _hiveDatabaseService.checkArticleDownloadStatus(article);
    }
  }

  toggleBookmark() {
    // to avoid alteration of a downloaded article bookmark
    // status
    if (article.downloaded) return;
    article.isBookmarked
        ? _removeArticleFromBookmark()
        : _addArticleToBookmark();
  }

  _addArticleToBookmark() async {
    print(article.isBookmarked);
    article.isBookmarked = true;
    bool isSuccess = false;
    setSecondaryBusy(ViewState.Busy);

    await _networkConfig.onNetworkAvailabilityToast(
      () async {
        isSuccess = await _articleService.addArticleToBookmark(article.id);
      },
    );
    if (!isSuccess) {
      if (article.isBookmarked) article.isBookmarked = false;
    }
    setSecondaryBusy(ViewState.Idle);
  }

  _removeArticleFromBookmark() async {
    print(article.isBookmarked);
    article.isBookmarked = false;
    bool isSuccess = false;
    setSecondaryBusy(ViewState.Busy);

    await _networkConfig.onNetworkAvailabilityToast(() async {
      isSuccess = await _articleService.removeArticleFromBookmark(article.id);
    });
    if (!isSuccess) {
      if (!article.isBookmarked) article.isBookmarked = true;
    }
    setSecondaryBusy(ViewState.Idle);
  }

  download() {
    if (downloaded) return;
    downloadPosition = -40;
    setBusy(ViewState.Idle);
    _hiveDatabaseService.downloadArticle(article);

    Future.delayed(Duration(milliseconds: 500), () {
      downloadPosition = 4;
      downloaded = true;
      //refreshing downloaded article list
      _articleDownloadViewModel.getArticles();
      setBusy(ViewState.Idle);
    });
  }

  deleteFromDownload() {
    downloadPosition = -40;
    setBusy(ViewState.Idle);
    _hiveDatabaseService.deleteArticle(article);
    article.downloaded = false;
    downloaded = false;
    Future.delayed(Duration(milliseconds: 500), () {
      downloadPosition = 4;
      //refreshing downloaded article list
      _articleDownloadViewModel.getArticles();
      setBusy(ViewState.Idle);
    });
  }
}
