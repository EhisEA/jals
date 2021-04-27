import 'dart:async';

import 'package:jals/models/content_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/ui/store/view_models/build_category_row_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../route_paths.dart';

class StoreViewModel extends BuildCategoryRowViewModel {
  NetworkConfig _networkConfig = new NetworkConfig();
  StoreService _storeService = locator<StoreService>();

  NavigationService _navigationService = locator<NavigationService>();

  navigateToWalletView() async {
    await _navigationService.navigateTo(PaymentPageWithTokenViewRoute);
  }

  List<ContentModel> newestItemList;
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

  getWalletBalance() async {}
}
