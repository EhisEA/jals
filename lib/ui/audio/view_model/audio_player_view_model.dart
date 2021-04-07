import 'package:audioplayers/audioplayers.dart';
import 'package:jals/utils/base_view_model.dart';

class AudioPlayerViewModel extends BaseViewModel {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration streamPosition;
  AudioPlayerState _currentAudioState = AudioPlayerState.STOPPED;
  bool get canPlay => _currentAudioState != AudioPlayerState.PLAYING;
  String url;

  @override
  dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  initiliseAudio(String url) async {
    this.url = url;
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
}
