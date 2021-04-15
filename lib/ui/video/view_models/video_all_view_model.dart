import 'package:jals/models/video_model.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:share/share.dart';

class VideoAllViewModel extends BaseViewModel {
  VideoService _videoService = locator<VideoService>();
  DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  List<VideoModel> _allVideoList;
  List<VideoModel> get allVideoList => _allVideoList;
  bool hasError = false;

  VideoAllViewModel() {
    getAllVideos();
  }
  Future<void> getAllVideos() async {
    setBusy(ViewState.Busy);
    await onNetwork();
    setBusy(ViewState.Idle);
  }

  onNetwork() async {
    try {
      _allVideoList = await _videoService.getVideoList();
    } catch (e) {
      print(e);
      hasError = true;
    }
  }

  onOptionSelect(value, VideoModel audio) async {
    final String link =
        await _dynamicLinkService.createEventLink(audio.toContent());
    switch (value.toString().toLowerCase()) {
      case "share":
        Share.share(link);
        break;
      default:
    }
  }
}
