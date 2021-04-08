import 'package:jals/models/store_model.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/ui/store/view_models/build_category_row_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class StoreViewModel extends BuildCategoryRowViewModel {
  NetworkConfig _networkConfig = new NetworkConfig();
  StoreService _storeService = locator<StoreService>();
  List<StoreModel> newestItemList = [];
  getNewestItems() async {
    try {
      setBusy(ViewState.Busy);
      await _networkConfig
          .onNetworkAvailabilityToast(onNetworkFetchNewestItems);
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  onNetworkFetchNewestItems() async {
    try {
      List<StoreModel> result = await _storeService.getNewestStoreItems();
      if (result.length >= 1) {
        newestItemList = result;
        notifyListeners();
      } else {
        newestItemList = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}