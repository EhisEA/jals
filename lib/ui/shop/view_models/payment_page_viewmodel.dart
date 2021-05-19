import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class PaymentPageViewModel extends BaseViewModel {
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
      var response = await _storeService.getWalletBalance();
      if (response != null) {
        print("==============Successfully got the wallet balance=============");
      } else {
        print("==============Error Occurred.=============");
      }
    } catch (e) {
      print(e);
    }
  }
}
