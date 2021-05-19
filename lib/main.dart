/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'consumable_store.dart';

void main() {
  // For play billing library 2.0 on Android, it is mandatory to call
  // [enablePendingPurchases](https://developer.android.com/reference/com/android/billingclient/api/BillingClient.Builder.html#enablependingpurchases)
  // as part of initializing the app.
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppHome());
  }
}

const bool kAutoConsume = true;

const String _kConsumableId = 'token1';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  "token2",
  "prop"
  // 'upgrade',
  // 'subscription'
];

class MyAppHome extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppHome> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    print("fetching");
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    print("fetching22222");
    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    print("fetching333333");
    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        print("adding");
        verifiedPurchases.add(purchase);
      }
    }
    print("===============");
    print(productDetailResponse.productDetails.length);
    // List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      // _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildConnectionCheckTile(),
            _buildProductList(),
            _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IAP Example'),
        ),
        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(child: ListTile(title: const Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
      title: Text(
          'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll([
        Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...'))));
    }
    if (!_isAvailable) {
      return Card();
    }
    final ListTile productHeader = ListTile(title: Text('Products for Sale'));
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verity the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails previousPurchase = purchases[productDetails.id];
        return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),
            trailing: previousPurchase != null
                ? Icon(Icons.check)
                : FlatButton(
                    child: Text(productDetails.price),
                    color: Colors.green[800],
                    textColor: Colors.white,
                    onPressed: () {
                      PurchaseParam purchaseParam = PurchaseParam(
                        productDetails: productDetails,
                        // applicationUserName: null,
                        // sandboxTesting: true,
                      );
                      // _connection.buyConsumable(
                      //   purchaseParam: purchaseParam,
                      //   // autoConsume: kAutoConsume || Platform.isIOS,
                      // );
                      _connection.buyNonConsumable(
                          purchaseParam: purchaseParam);
                    }
                    // if (productDetails.id == _kConsumableId) {
                    //   _connection.buyConsumable(
                    //       purchaseParam: purchaseParam,
                    //       autoConsume: kAutoConsume || Platform.isIOS);
                    // } else {
                    //   _connection.buyNonConsumable(
                    //       purchaseParam: purchaseParam);
                    // }
                    // },
                    ));
      },
    ));

    return Card(
        child:
            Column(children: <Widget>[productHeader, Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...'))));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return Card();
    }
    final ListTile consumableHeader =
        ListTile(title: Text('Purchased consumables'));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
      consumableHeader,
      Divider(),
      GridView.count(
        crossAxisCount: 5,
        children: tokens,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
      )
    ]));
  }

  Future<void> consume(String id) async {
    // await ConsumableStore.consume(id);
    // final List<String> consumables = await ConsumableStore.load();
    // setState(() {
    //   _consumables = consumables;
    // });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      setState(() {
        _purchasePending = false;
        // _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }
}



/////
///
///
///
///
*/

/// A store of consumable items.
///
/// This is a development prototype tha stores consumables in the shared
/// preferences. Do not use this in real world apps.
// class ConsumableStore {
//   static const String _kPrefKey = 'consumables';
//   static Future<void> _writes = Future.value();

//   /// Adds a consumable with ID `id` to the store.
//   ///
//   /// The consumable is only added after the returned Future is complete.
// static Future<void> save(String id) {
//   _writes = _writes.then((void _) => _doSave(id));
//   return _writes;
// }

//   /// Consumes a consumable with ID `id` from the store.
//   ///
//   /// The consumable was only consumed after the returned Future is complete.
//   static Future<void> consume(String id) {
//     _writes = _writes.then((void _) => _doConsume(id));
//     return _writes;
//   }

//   /// Returns the list of consumables from the store.
//   static Future<List<String>> load() async {
//     return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
//         [];
//   }

//   static Future<void> _doSave(String id) async {
//     List<String> cached = await load();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cached.add(id);
//     await prefs.setStringList(_kPrefKey, cached);
//   }

//   static Future<void> _doConsume(String id) async {
//     List<String> cached = await load();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cached.remove(id);
//     await prefs.setStringList(_kPrefKey, cached);
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jals/services/hive_database_service.dart';
import 'package:jals/ui/authentication/splashscreen_view.dart';
import 'package:jals/utils/theme.dart';
import 'utils/locator.dart';
import 'managers/dialog_manager.dart';
import 'utils/router.dart';
import 'services/dialog_service.dart';
import 'services/navigationService.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); //*====registering get_it
  //======= registering all type adpaters and
  //======= opening all local database for quick
  //======= access

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  locator<HiveDatabaseService>().openBoxes();
  return runApp(
    //DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(),
    // )
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JALS',
      builder: (context, child) {
        var dialogService = locator<DialogService>();
        // return DevicePreview.appBuilder(
        //     context,
        //     Navigator(
        //       key: dialogService.dialogNavigationKey,
        //       onGenerateRoute: (settings) => MaterialPageRoute(
        //           builder: (context) => DialogManager(child: child)),
        //     ));

        /// wraping all widgets inside Navigator and diaglog
        return Navigator(
          key: dialogService.dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        );
      },
      theme: MyTheme().themeData,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: SplashScreenView(),
    );

    // home: VideoPlayer());
  }
}
