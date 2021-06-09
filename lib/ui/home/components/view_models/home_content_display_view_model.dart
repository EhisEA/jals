import 'package:jals/enums/content_type.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/services/user_services.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

import '../../../../route_paths.dart';

class HomeContentDisplayViewModel extends BaseViewModel {
  List<ContentModel> contents;
  final UserServices _userServices = UserServices();
  void getContents({explore: false}) async {
    setBusy(ViewState.Busy);
    contents = explore
        ? await _userServices.getExplore()
        : await _userServices.getForYou();
    setBusy(ViewState.Idle);
  }

  openContent(index) {
    ContentModel _content = contents[index];

    NavigationService _navigationService = locator<NavigationService>();
    switch (_content.postType) {
      case ContentType.Article:
        _navigationService.navigateTo(ArticleViewRoute,
            argument: _content.toArticle());
        break;
      case ContentType.News:
        _navigationService.navigateTo(ArticleViewRoute,
            argument: _content.toArticle());
        break;
      case ContentType.Audio:
        //check if content is free or purchased
        //if not send to stores
        print(_content.toJson());
        if (_content.isPurchased == false && _content.price > 0) {
          _navigationService.navigateTo(StoreItemViewRoute, argument: {
            "content": _content,
            "callback": () => chagedContentToBought(index),
          });
          return;
        }

        _navigationService.navigateTo(AudioPlayerViewRoute, argument: {
          "audios": [_content.toAudio()],
          "playlistName": null
        });
        break;
      case ContentType.Video:
        _navigationService.navigateTo(VideoPlayerViewRoute,
            argument: _content.tovideo());
        break;
      default:
    }
  }

  chagedContentToBought(int index) {
    contents[index].isPurchased = true;
    openContent(index);
    setBusy(ViewState.Idle);
  }
}
