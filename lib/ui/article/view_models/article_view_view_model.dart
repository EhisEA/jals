import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/services/article_services.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/article/view_models/article_bookmarked_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:share/share.dart';

import 'article_download_view_model.dart';

class ArticleViewViewModel extends BaseViewModel {
  final _hiveDatabaseService = locator<HiveDatabaseService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final _articleDownloadViewModel = locator<ArticleDownloadViewModel>();
  ArticleService _articleService = ArticleService();
  NetworkConfig _networkConfig = NetworkConfig();
  ArticleModel article;
  bool downloaded;
  double downloadPosition = 4;
  String _articleDynamicLink;

  getArticleDetails(ArticleModel articleToView) async {
    setBusy(ViewState.Busy);
    if (articleToView.downloaded) {
      article = articleToView;
    } else {
      await _networkConfig.onNetworkAvailabilityDialog(() =>
          getArticleDetailsNetworkCall(articleToView.id, articleToView.isNews));
    }
    if (article != null)
      _articleDynamicLink =
          await _dynamicLinkService.createEventLink(article.toContent());

    setBusy(ViewState.Idle);
  }

  getArticleDetailsNetworkCall(String id, bool isNews) async {
    article = isNews
        ? await _articleService.getNewsDetails(id)
        : await _articleService.getArticleDetails(id);
    if (article != null) {
      downloaded = _hiveDatabaseService.checkArticleDownloadStatus(article.id);
    }
  }

// sharing

  share() async {
    if (article == null) return;

    if (_articleDynamicLink == null || _articleDynamicLink == "") {
      _articleDynamicLink =
          await _dynamicLinkService.createEventLink(article.toContent());
    }

    if (_articleDynamicLink == null || _articleDynamicLink == "") {
      Fluttertoast.showToast(
          msg: "No internet",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
    Share.share(_articleDynamicLink);
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
    } else {
      locator<ArticleBookMarkedViewModel>().getArticles();
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
    } else {
      locator<ArticleBookMarkedViewModel>().getArticles();
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
