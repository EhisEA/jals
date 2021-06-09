import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/ui/store/view_models/coin_balance_viewmodel.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class PaymentPageViewModel extends BaseViewModel {
  StoreService _storeService = locator<StoreService>();
  NetworkConfig _networkConfig = new NetworkConfig();

  ////////
  InAppPurchaseConnection _inAppPurchaseConnection =
      InAppPurchaseConnection.instance;
  bool available = true;
  StreamSubscription subscription;
  final String myProductID = "";

  ////////

  bool _isPurchased = false;
  bool get isPurchased => _isPurchased;
  set isPurchased(bool value) {
    _isPurchased = value;
  }

  ////////
  List _purchases = [];
  List get purchases => _purchases;
  set purchases(List value) {
    _purchases = value;
  }

  ////////
  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;
  set products(List value) {
    _products = value;
  }

  /////////

  final bool kAutoConsume = true;
  ////////
  buyCoin() {
    PurchaseParam purchaseParam = PurchaseParam(
      productDetails: products[selected],
      // applicationUserName: null,
      // sandboxTesting: true,
    );
    _inAppPurchaseConnection.buyConsumable(
      purchaseParam: purchaseParam,
      autoConsume: kAutoConsume || Platform.isIOS,
    );
  }

  ////////
  ///
  ///
  int selected;
  changeSelected(int value) {
    selected = value;
    setSecondaryBusy(ViewState.Idle);
  }

  ////////

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  ////////
  void initialize() async {
    setBusy(ViewState.Busy);
    available = await _inAppPurchaseConnection.isAvailable();

    if (available) {
      await _getProducts();
      await _getPastPurchases();
      verifyPurchase();
      subscription =
          _inAppPurchaseConnection.purchaseUpdatedStream.listen((data) {
        purchases.addAll(data);
        purchases.forEach((element) {
          verifyPurchase();
        });
      });
    }
    setBusy(ViewState.Idle);
  }

  void verifyPurchase() {
    PurchaseDetails purchase = hasPurchased("");
    if (purchase != null && purchase.status == PurchaseStatus.purchased) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchaseConnection.completePurchase(purchase).then((value) {
          print("completed purchased for");
          print(purchase.productID);
          informServerOfPurchase(purchase);
        });
      }
    }
  }

  informServerOfPurchase(PurchaseDetails purchase) async {
    ProductDetails p = products.firstWhere(
        (element) => element.id == purchase.productID,
        orElse: () => null);
    if (p != null) {
      // getting the coin total from the title
      String amount = p.title
          .replaceRange(
            p.title.length - 19,
            p.title.length,
            "",
          )
          .toLowerCase()
          .replaceAll("jals token", "")
          .trim();
      try {
        int coins = int.parse(amount);
        bool isSuccess = await _storeService.creditWallet(coins);
        if (isSuccess) {
          locator<CoinBalanceViewModel>().getWalletBalance();
        } else {
          informServerOfPurchase(purchase);
        }
      } catch (e) {
        print("======error==== in app purchase completion");
        print(e);
      }
    }
  }

// check if user has the itme in his purchased list
  PurchaseDetails hasPurchased(String productId) {
    return purchases.firstWhere((purchase) => purchase.productId == productId,
        orElse: () => null);
  }

//check if my listed product exist and get them from the store
  Future<void> _getProducts() async {
    Set<String> ids = Set.from([
      "token1",
      "token2",
      "prop",
    ]);
    ProductDetailsResponse response =
        await _inAppPurchaseConnection.queryProductDetails(ids);
    products = response.productDetails;
  }

  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response =
        await _inAppPurchaseConnection.queryPastPurchases();
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _inAppPurchaseConnection.consumePurchase(purchase);
      }
    }
    purchases = response.pastPurchases;
  }

  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////
  ////////

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
