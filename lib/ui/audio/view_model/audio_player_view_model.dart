import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';

class AudioPlayerViewModel extends BaseViewModel {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioService _audioService = AudioService();
  Duration totalDuration;
  Duration streamPosition;
  Duration bufferedPosition;
  // AudioPlayerState _currentAudioState = AudioPlayerState.STOPPED;
  // bool get canPlay => _currentAudioState != AudioPlayerState.PLAYING;
  bool get canPlay => audioPlayer.playerState?.playing ?? false;
  AudioModel currentlyPlaying;
  // int currentlyPlayingIndex;
  List<AudioModel> audios;
  List<PlayListModel> playList;
  ConcatenatingAudioSource _songs;
  String playlistName;
  // bool get hasNext => audios.length > currentlyPlayingIndex;
  // bool get hasPrev => currentlyPlayingIndex > 0;

  @override
  dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  initiliseAudio(List<AudioModel> audios, {String playlistName}) async {
    _songs = ConcatenatingAudioSource(
      children: List.generate(
        audios.length,
        (index) => AudioSource.uri(
          Uri.parse(audios[index].dataUrl),
          // "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
          tag: audios[index],

          // AudioMetadata(
          //   album: "Science Friday",
          //   title: "A Salute To Head-Scratching Science",
          //   artwork:
          //       "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
          // ),
        ),
      ),
    );

    this.audios = audios;
    // this.currentlyPlayingIndex = 0;
    // this.currentlyPlaying = audios[currentlyPlayingIndex];
    this.playlistName = playlistName;

    // audioPlayer.onDurationChanged.listen((Duration duration) {
    //   totalDuration = duration;
    //   setBusy(ViewState.Idle);
    // });

    audioPlayer.bufferedPositionStream.listen((Duration duration) {
      bufferedPosition = duration;
      setBusy(ViewState.Idle);
    });
    audioPlayer.positionStream.listen((Duration duration) {
      streamPosition = duration;
      setBusy(ViewState.Idle);
    });

    audioPlayer.durationStream.listen((Duration duration) {
      totalDuration = duration;
      setBusy(ViewState.Idle);
    });
    // audioPlayer.onAudioPositionChanged.listen((Duration duration) {
    //   streamPosition = duration;
    //   audioPlayer.onPlayerCompletion.listen((event) {
    //     print("Comple");
    // //   });
    //   if (streamPosition == totalDuration) {
    //     print(333);
    //     // audioPlayer.
    //   }
    //   setBusy(ViewState.Idle);
    // });
    //
    audioPlayer.sequenceStateStream.listen((SequenceState sequenceState) {
      currentlyPlaying = sequenceState.currentSource.tag as AudioModel;
    });

    audioPlayer.playerStateStream.listen((PlayerState state) {
      print(state);
      if (state.processingState == ProcessingState.completed) {
        if (audioPlayer.hasNext) {
          // // audioPlayer.release();
          // streamPosition = Duration(seconds: 0);
          // this.currentlyPlayingIndex = currentlyPlayingIndex++;
          // this.currentlyPlaying = audios[currentlyPlayingIndex];
          // play();
        } else {
          streamPosition = Duration(seconds: 0);
        }
      }
      setBusy(ViewState.Idle);
    });
    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    // audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
    //   print(state);
    //   _currentAudioState = state;
    //   if (state == AudioPlayerState.COMPLETED) {
    //     if (hasNext) {
    //       audioPlayer.release();
    //       streamPosition = Duration(seconds: 0);
    //       this.currentlyPlayingIndex = currentlyPlayingIndex++;
    //       this.currentlyPlaying = audios[currentlyPlayingIndex];
    //       play();
    //     } else {
    //       streamPosition = Duration(seconds: 0);
    //     }
    //   }
    //   setBusy(ViewState.Idle);
    // });

    // audioPlayer.
    // audioPlayer.onPlayerError.listen((error) {
    //   audioPlayer.state;
    //   print("eeeeeeee");
    //   print(error);
    // });

    // audioPlayer
    //   ..listen((error) {
    //     audioPlayer.state;
    //     print("eeeeeeee");
    //     print(error);
    //   });

    try {
      await audioPlayer.setAudioSource(_songs);
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
    }
    // play();
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
    // print(audios);
    // print(currentlyPlaying.dataUrl);
    // audioPlayer.play();
    // audioPlayer.play(currentlyPlaying.dataUrl);
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
