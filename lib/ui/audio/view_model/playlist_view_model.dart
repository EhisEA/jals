import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:share/share.dart';

class PlaylistViewModel extends BaseViewModel {
  AudioService _audioService = AudioService();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  PlayListModel playList;
  PlaylistViewModel(this.playList);

  onOptionSelect(value, AudioModel audio) async {
    final String link =
        await _dynamicLinkService.createEventLink(audio.toContent());
    switch (value.toString().toLowerCase()) {
      case "remove":
        _removeFromPlaylist(playList.id, audio);
        break;
      case "share":
        Share.share(link);
        break;
      default:
    }
  }

  _removeFromPlaylist(String playlistId, AudioModel audio) async {
    setSecondaryBusy(ViewState.Busy);
    await _removeFromPlaylistNewtworkCall(playlistId, audio);
    setSecondaryBusy(ViewState.Idle);
  }

  _removeFromPlaylistNewtworkCall(String playlistId, AudioModel audio) async {
    print("Start");
    ApiResponse result =
        await _audioService.removeAudioFromPlaylist(playlistId, audio.id);
// https://jals.page.link/JohhSfKxJ4rS4mVY9
    switch (result) {
      case ApiResponse.Success:
        Fluttertoast.showToast(
          msg: "Removed From playlist",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
        );
        playList.count--;
        playList.tracks.removeWhere((element) => element.id == audio.id);
        break;
      case ApiResponse.Error:
        Fluttertoast.showToast(
          msg: "Failed to Remove From playlis",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Failed to Remove From playlis",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
    }
  }
}
