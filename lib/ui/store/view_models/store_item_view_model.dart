import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jals/enums/content_type.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/ui/store/view_models/coin_balance_viewmodel.dart';
import 'package:jals/ui/store/view_models/newest_items_view_model.dart';
import 'package:jals/ui/store/view_models/purchased_view_model.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:jals/widgets/button.dart';

class StoreItemViewModel extends BaseViewModel {
  StoreService _storeService = locator<StoreService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  Function callback;
  BuildContext context;
// *****88********88*Video=============
  void buyVideo(String id) async {
    try {
      setBusy(ViewState.Busy);
      await _networkConfig
          .onNetworkAvailabilityDialog(() => buyVideoOnNetwork(id));
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  void buyVideoOnNetwork(String id) async {
    Map<String, String> apiResponse = await _storeService.buyVideo(id);
    if (apiResponse['response'] == 'Success') {
      setBusy(ViewState.Idle);
      print("Purchased Successfully, You have ... coins left");

      await successDialog(); //show success message
      _navigationService.goBack(); //leave the view
      callback(); //inform initial view model of the successful transaction
      //remove item from timeline view
      locator<StoreTimelineItemsViewModel>().searchAndRemoveContent(id);
      //remove item from store view
      locator<NewestItemsViewModel>().searchAndRemoveContent(id);
      //refresh purchase to get new items
      locator<PurchasedItemsViewModel>().getNewestItems();
      // refresh wallet balance
      locator<CoinBalanceViewModel>().getWalletBalance();
    } else {
      print("Hello An Error Occured");
      setBusy(ViewState.Idle);
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "An Error Occured",
      );
    }
  }

//============buy audio======
  void buyAudio(String id) async {
    try {
      setBusy(ViewState.Busy);
      await _networkConfig
          .onNetworkAvailabilityDialog(() => buyAudioOnNetwork(id));
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  void buyAudioOnNetwork(String id) async {
    Map<String, String> apiResponse = await _storeService.buyAudio(id);

    if (apiResponse['response'] == 'Success') {
      print("Purchased Successfully, You have ... coins left");
      setBusy(ViewState.Idle);
      await successDialog(); //show success message
      _navigationService.goBack(); //leave the view
      callback(); //inform initial view model of the successful transaction
      //remove item from timeline view
      locator<StoreTimelineItemsViewModel>().searchAndRemoveContent(id);
      //remove item from store view
      locator<NewestItemsViewModel>().searchAndRemoveContent(id);
      //refresh purchase to get new items
      locator<PurchasedItemsViewModel>().getNewestItems();
      // refresh wallet balance
      locator<CoinBalanceViewModel>().getWalletBalance();
    } else {
      print("Hello An Error Occured");
      setBusy(ViewState.Idle);
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "An Error Occured",
      );
    }
  }

//=============buyv sermon=======
  void buySermon(String id) async {
    try {
      setBusy(ViewState.Busy);
      await _networkConfig
          .onNetworkAvailabilityDialog(() => buySermonOnNetwork(id));
      setBusy(ViewState.Idle);
    } catch (e) {
      print(e);
      setBusy(ViewState.Idle);
    }
  }

  void buySermonOnNetwork(String id) async {
    Map<String, String> apiResponse = await _storeService.buySermon(id);
    if (apiResponse['response'] == 'Success') {
      print("Purchased Successfully, You have ... coins left");
      setBusy(ViewState.Idle);
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "An Error Occured",
      );
    } else {
      print("Hello An Error Occured");
      setBusy(ViewState.Idle);
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "An Error Occured",
      );
    }
  }

//Genaral Purchase
  genaralPurchase(ContentType type, String id) {
    if (type == ContentType.Video) {
      buyVideo(id);
    } else if (type == ContentType.Audio) {
      buyAudio(id);
    } else if (type == ContentType.Article) {
      buySermon(id);
    } else {
      print("None...");
    }
  }

  Future<bool> successDialog() {
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            child: Align(
              child: Container(
                margin: EdgeInsets.all(50),
                padding: EdgeInsets.all(20),
                height: 250,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified,
                      size: 80,
                      color: kGreen,
                    ),
                    Text("You have successfully purchased this item"),
                    SizedBox(height: 30),
                    DefaultButtonBordered(
                      press: () {
                        Navigator.pop(context);
                      },
                      color: kGreen,
                      text: "Okay",
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
