import 'package:jals/models/content_model.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class NewestItemsViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = new NetworkConfig();
  StoreService _storeService = locator<StoreService>();
  List<ContentModel> newestItemList = [];
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
      List<ContentModel> result = await _storeService.getNewestStoreItems();
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
