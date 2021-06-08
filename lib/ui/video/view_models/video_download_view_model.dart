import 'package:jals/models/video_model.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class VideoDownloadViewModel extends BaseViewModel {
  final _hiveDatabaseService = locator<HiveDatabaseService>();

  List<VideoModel> videos = [];
  getVideos() async {
    setBusy(ViewState.Busy);
    try {
      videos = _hiveDatabaseService.getDownloadedVideos();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }
}
