import 'package:hive/hive.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/content_model.dart';

class HiveDatabaseService {
  Box<ArticleModel> _articleDownloads;
  Box<ContentModel> videoDownloads;
  Box<ContentModel> audioDownloads;

  HiveDatabaseService() {
    Hive.registerAdapter(ContentModelAdapter());
    Hive.registerAdapter(ArticleModelAdapter());
  }

  void openBoxes() async {
    _articleDownloads = await Hive.openBox<ArticleModel>('article_downloads');
    print(_articleDownloads.length);

    // _articleDownloads.clear();
    // articleDownloads = await Hive.openBox<ContentModel>('video_downloads');
    // articleDownloads = await Hive.openBox<ContentModel>('audio_downloads');
  }

  void downloadArticle(ArticleModel article) {
    article.downloaded = true;
    article.downloadDate = DateTime.now();
    _articleDownloads.put(article.id, article);
  }

  void deleteArticle(ArticleModel article) {
    _articleDownloads.delete(article.id);
  }

  List<ArticleModel> getDownloadedArticle() {
    return _articleDownloads.values.toList();
  }

  bool checkArticleDownloadStatus(ArticleModel article) {
    // if (_articleDownloads == null) return false;
    return _articleDownloads.containsKey(article.id);
  }
}
