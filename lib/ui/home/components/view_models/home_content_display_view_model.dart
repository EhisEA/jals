import 'package:jals/models/content_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/services/user_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

import '../../../../route_paths.dart';

class HomeContentDisplayViewModel extends BaseViewModel {
  List<ContentModel> contents;
  final UserServices _userServices = UserServices();
  void getContents() async {
    setBusy(ViewState.Busy);
    contents = await _userServices.getExplore();
    setBusy(ViewState.Idle);
  }

  openContent(index) {
    ContentModel _content = contents[index];

    NavigationService _navigationService = locator<NavigationService>();
    switch (_content.postType) {
      case ContentType.Article:

          _navigationService.navigateTo(ArticleViewRoute, argument: _content.toArticle());
        break;
      case ContentType.News:

          _navigationService.navigateTo(ArticleViewRoute, argument: _content.toArticle());
        break;
      case ContentType.Audio:

          _navigationService.navigateTo(AudioPlayerViewRoute, argument: _content.toAudio());
        break;
      case ContentType.Video:

          _navigationService.navigateTo(VideoPlayerViewRoute, argument: _content.tovideo());
        break;
      default:
    }
  }
}
