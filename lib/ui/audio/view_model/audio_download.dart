import 'package:jals/models/audio_model.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class AudioDownloadViewModel extends BaseViewModel {
  final _hiveDatabaseService = locator<HiveDatabaseService>();

  List<AudioModel> audio;
  getAudios() async {
    setBusy(ViewState.Busy);
    try {
      audio = _hiveDatabaseService.getDownloadedAudios();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }
}
