import 'package:audio_service/audio_service.dart' as audio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/audio/view_model/audio_playlist_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/comment_widget.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:share/share.dart';

import 'audioService.dart';

void audioPlayerTaskEntrypoint() async {
  print('initializing');
  audio.AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerViewModel extends BaseViewModel {
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final HiveDatabaseService _hiveDatabaseService =
      locator<HiveDatabaseService>();
  CommentWidgetViewModel commentWidgetViewModel;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioService _audioService = AudioService();
  Duration totalDuration;
  Duration streamPosition;
  Duration bufferedPosition;
  int playinIndex = 0;
  // AudioPlayerState _currentAudioState = AudioPlayerState.STOPPED;
  // bool get canPlay => _currentAudioState != AudioPlayerState.PLAYING;
  bool get canPlay => audioPlayer.playerState?.playing ?? false;
  AudioModel currentlyPlaying;
  // int currentlyPlayingIndex;
  List<AudioModel> audios;
  List<PlayListModel> playList;
  List<CommentWidgetViewModel> commentWidgetViewModels;
  List<CommentWidget> commentWidgets;
  ConcatenatingAudioSource _songs;
  String playlistName;
  String _dynamicLink;
  // bool get hasNext => audios.length > currentlyPlayingIndex;
  // bool get hasPrev => currentlyPlayingIndex > 0;

  @override
  dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  checkDownload(int index) async {
    audios[index].downloaded =
        await _hiveDatabaseService.checkAudioDownloadStatus(audios[index].id);
    if (audios[index].downloaded) {
      audios[index].dataUrl =
          _hiveDatabaseService.getSingleAudio(audios[index].id).dataUrl;
    }
  }

  startAudioPlayerBtn(List<AudioModel> audios, {String playlistName}) async {
    // await audio.AudioService.connect().catchError((e){
    //   print(e.toString());
    // });
    print('Starting');
    print('running');

    this.audios = audios;
    commentWidgetViewModels = audios.map<CommentWidgetViewModel>((audio) {
      return CommentWidgetViewModel(audio.realId);
    }).toList();
    commentWidgets = commentWidgetViewModels
        .map<CommentWidget>(
            (commentVM) => CommentWidget(commentWidgetViewModel: commentVM))
        .toList();
    setBusy(ViewState.Busy);
    for (int i = 0; i < audios.length; i++) {
      print("i==$i ${audios.length}");
      await checkDownload(i);
    }

    List<dynamic> list = [];
    for (int i = 0; i < audios.length; i++) {
      var m = audios[i].toJson();
      list.add(m);
    }
    print(list);
    var params = {"data": list};
    print(list.length);
    print('This is the list' + list.length.toString());
    print(list);
    await audio.AudioService.start(
      androidEnableQueue: true,
      backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Player',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: params,
    ).whenComplete(() {
      print("00000");
      print('Completed');
    }).catchError((e) {
      print('Failed');
      print(e.toString());
    });

    setBusy(ViewState.Idle);
  }

  initiliseAudio(List<AudioModel> audios, {String playlistName}) async {
    this.audios = audios;
    commentWidgetViewModels = audios.map<CommentWidgetViewModel>((audio) {
      return CommentWidgetViewModel(audio.id);
    }).toList();
    commentWidgets = commentWidgetViewModels
        .map<CommentWidget>(
            (commentVM) => CommentWidget(commentWidgetViewModel: commentVM))
        .toList();
    setBusy(ViewState.Busy);
    for (int i = 0; i < audios.length; i++) {
      print("i==$i ${audios.length}");
      await checkDownload(i);
    }
    setBusy(ViewState.Idle);
    _songs = ConcatenatingAudioSource(children: [
      ...List.generate(
        audios.length,
        (index) => AudioSource.uri(
          Uri.parse(audios[index].dataUrl),
          tag: audios[index],

          // AudioMetadata(
          //   album: "Science Friday",
          //   title: "A Salute To Head-Scratching Science",
          //   artwork:
          //       "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
          // ),
        ),
      ),
      // AudioSource
    ]);

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
      print("change");
      if (sequenceState != null) {
        currentlyPlaying = sequenceState.currentSource.tag as AudioModel;
        commentWidgetViewModel = CommentWidgetViewModel(currentlyPlaying.id);
        commentWidgetViewModel.getComments();
        playinIndex = -1;
        Future.delayed(Duration(milliseconds: 500), () {
          playinIndex = sequenceState.currentIndex;
          setSecondaryBusy(ViewState.Idle);
        });
        setSecondaryBusy(ViewState.Idle);
      }
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

      if (currentlyPlaying != null)
        _dynamicLink = await _dynamicLinkService
            .createEventLink(currentlyPlaying.toContent());
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      Fluttertoast.showToast(
        msg: "Failed to load audio",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    // play();
    // audioPlayer.
  }

  seek(double milliseconds) {
    audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
    setBusy(ViewState.Idle);
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

        locator<AudioPlaylistSectionViewModel>().addAudio(playlistId, audio);
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

// sharing

  share() async {
    if (currentlyPlaying == null) return;

    if (_dynamicLink == null || _dynamicLink == "") {
      _dynamicLink = await _dynamicLinkService
          .createEventLink(currentlyPlaying.toContent());
    }

    if (_dynamicLink == null || _dynamicLink == "") {
      Fluttertoast.showToast(
          msg: "No internet",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
    Share.share(_dynamicLink);
  }
}
