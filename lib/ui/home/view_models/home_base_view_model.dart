import 'package:jals/utils/base_view_model.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeBaseViewModel extends BaseViewModel {
  final PersistentTabController controller = PersistentTabController();

  changeTab(int index) {
    controller.jumpToTab(index);
    setBusy(ViewState.Idle);
  }
}
