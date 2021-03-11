import 'package:hive/hive.dart';
import 'package:jals/models/content_model.dart';

class HiveDatabaseService {
  Box<ContentModel> articleDownloads;
  Box<ContentModel> videoDownloads;
  Box<ContentModel> audioDownloads;

  HiveDatabaseService() {
    Hive.registerAdapter(ContentModelAdapter());
  }

  openBoxes() async {
    articleDownloads = await Hive.openBox<ContentModel>('article_downloads');
    articleDownloads = await Hive.openBox<ContentModel>('video_downloads');
    articleDownloads = await Hive.openBox<ContentModel>('audio_downloads');
  }
}
