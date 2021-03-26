import 'package:jals/models/audio_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class AudioAllViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  AudioService _audioService = AudioService();
  List<AudioModel> audioList;
  getAudio() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(getArticlesNewtworkCall);
    setBusy(ViewState.Idle);
  }

  getArticlesNewtworkCall() async {
    audioList = await _audioService.getAudioList();
  }
}
