import 'package:jals/utils/base_view_model.dart';

class BuildCategoryRowViewModel extends BaseViewModel {
  List<String> items = [
    "Newest",
    "Timeline",
    "Purchased",
  ];
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String textTitle() {
    switch (selectedIndex) {
      case 0:
        return "Newest Collection";
      case 1:
        return "";
      case 2:
        return "";
        break;
      default:
        return "";
    }
  }
}
