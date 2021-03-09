import 'package:jals/utils/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  getForYou() async {
    setBusy(ViewState.Busy);

    setBusy(ViewState.Idle);
  }
}
