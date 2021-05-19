import 'package:jals/services/navigationService.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

import '../../../route_paths.dart';

class CoinBalanceViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  double coins = 0;
  navigateToWalletView() async {
    await _navigationService.navigateTo(
      PaymentPageWithTokenViewRoute,
      argument: coins,
    );
  }

  StoreService _storeService = locator<StoreService>();
  NetworkConfig _networkConfig = new NetworkConfig();

  void getWalletBalance() async {
    setBusy(ViewState.Busy);
    await _networkConfig
        .onNetworkAvailabilityToast(() => getWalletBallenceOnNetwork);
    setBusy(ViewState.Idle);
  }

  void getWalletBallenceOnNetwork() async {
    try {
      double response = await _storeService.getWalletBalance();
      coins = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
