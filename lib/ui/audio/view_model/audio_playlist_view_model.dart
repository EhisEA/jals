import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/dialog_models.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class AudioPlaylsitViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  AudioService _audioService = AudioService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey333 = GlobalKey();

  List<PlayListModel> playList;

  int moodColorIndex;

  TextEditingController playlistNameController = TextEditingController();

  changeMoodColorIndex(int index) {
    moodColorIndex = index;
    setBusy(ViewState.Idle);
  }

  getPlaylist() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(_getPlaylistNewtworkCall);
    setBusy(ViewState.Idle);
  }

  _getPlaylistNewtworkCall() async {
    playList = await _audioService.getPlaylist();
  }

  createPlaylist() async {
    await _networkConfig
        .onNetworkAvailabilityDialog(_createPlaylistNetworkCall);
  }

  _createPlaylistNetworkCall() async {
    if (playlistNameController.text.length >= 1) {
      setSecondaryBusy(ViewState.Busy);
      bool response =
          await _audioService.createPlaylist(playlistNameController.text);

      if (response) {
        Fluttertoast.showToast(msg: "Playlist Created");
        playlistNameController.clear();
        getPlaylist();
      } else {
        Fluttertoast.showToast(
            msg: "Could not create playlist: please try again");
      }
      setSecondaryBusy(ViewState.Idle);
    }
  }

  onDelete(int index) async {
    DialogResponse _response = await _dialogService.showConfirmationDialog(
      title: "Delete playlist",
      description: "Are you sure you want to delete this playlist",
      confirmationTitle: "Yes",
    );
    if (_response.confirmed) {
      await _onDeleteNetworkCall(index);
    }
  }

  _onDeleteNetworkCall(int index) async {
    bool response = await _audioService.deletePlaylist(playList[index].id);

    if (response) {
      playList.removeAt(index);
      Fluttertoast.showToast(
        msg: "Playlist deleted",
        textColor: Colors.white,
        backgroundColor: kPrimaryColor,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Playlist failed to deleted",
        textColor: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }
}
