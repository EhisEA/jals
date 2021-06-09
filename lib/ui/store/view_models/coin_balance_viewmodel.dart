import 'package:jals/services/navigationService.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../route_paths.dart';

class CoinBalanceViewModel extends BaseViewModel {
  int coins = 0;
  navigateToWalletView() async {
    NavigationService _navigationService = locator<NavigationService>();
    await _navigationService.navigateTo(
      PaymentPageWithTokenViewRoute,
      argument: coins,
    );
  }

  StoreService _storeService = StoreService();
  NetworkConfig _networkConfig = new NetworkConfig();

  void getWalletBalance() async {
    setBusy(ViewState.Busy);
    await _getWalletBalanceOnNetwork();
  }

  Future<void> _getWalletBalanceOnNetwork() async {
    try {
      int response = await _storeService.getWalletBalance();
      if (response == null) {
        print("Again");
        getWalletBalance();
        return;
      }
      coins = response;
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }
}
