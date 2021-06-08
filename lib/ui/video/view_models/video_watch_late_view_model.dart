import 'package:jals/models/video_model.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/video_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:share/share.dart';

class VideoWatchLaterViewModel extends BaseViewModel {
  VideoService _videoService = locator<VideoService>();
  DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  List<VideoModel> _videoWatchLaterList;
  List<VideoModel> get videoWatchLaterList => _videoWatchLaterList;

  VideoWatchLaterViewModel() {
    getAllVideos();
  }
  Future<void> getAllVideos() async {
    setBusy(ViewState.Busy);
    await onNetwork();
    setBusy(ViewState.Idle);
  }

  onNetwork() async {
    try {
      _videoWatchLaterList = await _videoService.getBookmarkedVideoList();
    } catch (e) {
      print(e);
    }
  }

  clear() {
    _videoWatchLaterList = null;
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
