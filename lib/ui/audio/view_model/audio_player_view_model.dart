import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';

class AudioPlayerViewModel extends BaseViewModel {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioService _audioService = AudioService();
  Duration totalDuration;
  Duration streamPosition;
  AudioPlayerState _currentAudioState = AudioPlayerState.STOPPED;
  bool get canPlay => _currentAudioState != AudioPlayerState.PLAYING;
  String url;
  List<String> urls;
  List<PlayListModel> playList;

  @override
  dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  initiliseAudio(List<String> urls) async {
    this.urls = urls;
    this.url = urls[0];
    audioPlayer.onDurationChanged.listen((Duration duration) {
      totalDuration = duration;
      setBusy(ViewState.Idle);
    });

    audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      streamPosition = duration;
      setBusy(ViewState.Idle);
    });

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print(state);
      _currentAudioState = state;
      if (state == AudioPlayerState.COMPLETED)
        streamPosition = Duration(seconds: 0);
      setBusy(ViewState.Idle);
    });
// audioPlayer.
    audioPlayer.onPlayerError.listen((error) {
      audioPlayer.state;
      print("eeeeeeee");
      print(error);
    });

    play();
    // audioPlayer.
  }

  seek(double milliseconds) {
    audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
    setBusy(ViewState.Idle);
  }

  play_pause() {
    canPlay ? play() : pause();
  }

  play() {
    audioPlayer.play(url);
  }

  pause() async {
    audioPlayer.pause();
  }

  getPlaylist() async {
    setSecondaryBusy(ViewState.Busy);
    await _getPlaylistNewtworkCall();
    setSecondaryBusy(ViewState.Idle);
  }

  _getPlaylistNewtworkCall() async {
    playList = await _audioService.getPlaylist();
  }

  addToPlaylist(String playlistId, AudioModel audio) async {
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
