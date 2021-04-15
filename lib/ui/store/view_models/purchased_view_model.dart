import 'package:jals/models/content_model.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class PurchasedItemsViewModel extends BaseViewModel {
  bool isLoading = false;
  StoreService _storeService = locator<StoreService>();
  List<ContentModel> purchaseItemList = [];
  Future<void> getNewestItems() async {
    try {
      setBusy(ViewState.Busy);
      await onNetworkFetchNewestItems();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }

  onNetworkFetchNewestItems() async {
    //null means there was a network or server error
    //empty means no item
    //when data is availble it  display
    try {
      purchaseItemList = await _storeService.getPurchasedItemsList();
    } catch (e) {
      purchaseItemList = null;
    }
  }
}
