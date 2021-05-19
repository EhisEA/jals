import 'package:jals/models/audio_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/services/dynamic_link_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:share/share.dart';

class AudioAllViewModel extends BaseViewModel {
  AudioService _audioService = AudioService();
  DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  List<AudioModel> audioList;

  AudioAllViewModel() {
    getAudio();
  }
  Future<void> getAudio() async {
    setBusy(ViewState.Busy);
    await _getAudioNewtworkCall();
    setBusy(ViewState.Idle);
  }

  _getAudioNewtworkCall() async {
    audioList = await _audioService.getAudioList();
  }

  onOptionSelect(value, AudioModel audio) async {
    final String link =
        await _dynamicLinkService.createEventLink(audio.toContent());
    switch (value.toString().toLowerCase()) {
      case "share":
        Share.share(link);
        break;
      default:
    }
  }
}
