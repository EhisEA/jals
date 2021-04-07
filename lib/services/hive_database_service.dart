import 'package:hive/hive.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/models/content_model.dart';

class HiveDatabaseService {
  Box<ArticleModel> _articleDownloads;
  Box<ContentModel> videoDownloads;
  Box<ContentModel> audioDownloads;

  HiveDatabaseService() {
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

  bool checkArticleDownloadStatus(String id) {
    // if (_articleDownloads == null) return false;
    return _articleDownloads.containsKey(id);
  }

  String getArticleDownloadedContent(String id) {
    // if (_articleDownloads == null) return false;
    return _articleDownloads.get(id)==null?null:_articleDownloads.get(id).content;
  }
}
