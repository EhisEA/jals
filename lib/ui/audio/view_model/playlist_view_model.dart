import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';

class PlaylistViewModel extends BaseViewModel {
  AudioService _audioService = AudioService();

  PlayListModel playList;
  PlaylistViewModel(this.playList);

  onOptionSelect(value, AudioModel audio) {
    switch (value.toString().toLowerCase()) {
      case "remove":
        _removeFromPlaylist(playList.id, audio);
        break;
      case "share":
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
    print("End");
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
