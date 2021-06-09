import 'package:jals/models/content_model.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/ui/store/purchased_items_view.dart';
import 'package:jals/ui/store/view_models/purchased_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class NewestItemsViewModel extends BaseViewModel {
  bool isLoading = false;
  StoreService _storeService = locator<StoreService>();
  List<ContentModel> newestItemList = [];
  Future<void> getNewestItems() async {
    try {
      setBusy(ViewState.Busy);
      // isLoading = true;
      // await _networkConfig
      //     .onNetworkAvailabilityToast(onNetworkFetchNewestItems);
      await onNetworkFetchNewestItems();
      // setBusy(ViewState.Idle);
      // isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }

  onNetworkFetchNewestItems() async {
    try {
      newestItemList = await _storeService.getNewestStoreItems();
    } catch (e) {
      newestItemList = null;
    }
  }

  changeTimeline(DateTime th, DateTime tl) async {
    try {
      print(th);
      print(tl);

      setBusy(ViewState.Busy);
      newestItemList = await _storeService.getNewestStoreItems(th: th, tl: tl);
    } catch (e) {
      print(e);
      newestItemList = null;
    }
    setBusy(ViewState.Idle);
  }

  addItemToPurchased(int index) {
    newestItemList.removeAt(index);
    setBusy(ViewState.Idle);
  }

//it is used to remove any purchased item from it list
  searchAndRemoveContent(String id) {
    if (newestItemList != null) if (newestItemList.isNotEmpty)
      newestItemList.removeWhere((element) => element.id == id);
    setBusy(ViewState.Idle);
  }
}

class StoreTimelineItemsViewModel extends BaseViewModel {
  bool isLoading = false;
  StoreService _storeService = locator<StoreService>();
  List<ContentModel> newestItemList = [];
  Future<void> getNewestItems() async {
    try {
      setBusy(ViewState.Busy);
      // isLoading = true;
      // await _networkConfig
      //     .onNetworkAvailabilityToast(onNetworkFetchNewestItems);
      await onNetworkFetchNewestItems();
      // setBusy(ViewState.Idle);
      // isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(ViewState.Idle);
  }

  onNetworkFetchNewestItems() async {
    try {
      newestItemList = await _storeService.getNewestStoreItems();
    } catch (e) {
      newestItemList = null;
    }
  }

  changeTimeline(DateTime th, DateTime tl) async {
    try {
      print(th);
      print(tl);

      setBusy(ViewState.Busy);
      newestItemList = await _storeService.getNewestStoreItems(th: th, tl: tl);
    } catch (e) {
      print(e);
      newestItemList = null;
    }
    setBusy(ViewState.Idle);
  }

  addItemToPurchased(int index) {
    newestItemList.removeAt(index);
    setBusy(ViewState.Idle);
  }

//it is used to remove any purchased item from it list
  searchAndRemoveContent(String id) {
    print("pppp");
    // if (newestItemList != null) if (newestItemList.isNotEmpty)
    newestItemList.removeWhere((element) => element.id == id);
    setBusy(ViewState.Idle);
  }
}
