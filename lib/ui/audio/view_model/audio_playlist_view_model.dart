import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/dialog_models.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class AudioPlaylistSectionViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  AudioService _audioService = AudioService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey333 = GlobalKey();

  List<PlayListModel> playList;

  int moodColorIndex;

  TextEditingController playlistNameController = TextEditingController();

  AudioPlaylistSectionViewModel() {
    getPlaylist();
  }

  changeMoodColorIndex(int index) {
    moodColorIndex = index;
    setBusy(ViewState.Idle);
  }

  Future<void> getPlaylist() async {
    setBusy(ViewState.Busy);
    await _getPlaylistNewtworkCall();
    setBusy(ViewState.Idle);
  }

  _getPlaylistNewtworkCall() async {
    playList = await _audioService.getPlaylist();
  }

  createPlaylist() async {
    await _networkConfig
        .onNetworkAvailabilityDialog(_createPlaylistNetworkCall);
  }

  addAudio(String playlistId, AudioModel audio) {
    playList = playList.map((value) {
      //if playlist found
      if (value.id == playlistId) {
        //check if audio exist in playlist track
        bool exist = false;
        value.tracks.forEach((element) {
          if (element.id == audio.id) exist = true;
        });
        // if audio does not exist in playlist track
        //add audio to track
        if (!exist) {
          value.tracks.add(audio);
          value.count++;
        }
      }
      return value;
    }).toList();
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

  removeToPlaylist(String playlistId, AudioModel audio) async {
    setSecondaryBusy(ViewState.Busy);
    await _addPlaylistNewtworkCall(playlistId, audio);
    setSecondaryBusy(ViewState.Idle);
  }

  _addPlaylistNewtworkCall(String playlistId, AudioModel audio) async {
    ApiResponse result =
        await _audioService.addAudioToPlaylist(playlistId, audio.id);

    switch (result) {
      case ApiResponse.Success:
        Fluttertoast.showToast(
          msg: "Added to playlist",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
        );

        playList = playList.map((PlayListModel element) {
          if (element.id == playlistId) {
            element.count++;
          }
          return element;
        }).toList();
        break;
      case ApiResponse.Error:
        Fluttertoast.showToast(
          msg: "Failed to add to playlis",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Failed to add to playlis",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
    }
  }
}
