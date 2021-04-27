import 'dart:io';

import 'package:jals/enums/content_type.dart';
import 'package:jals/services/dialog_service.dart';
import 'package:jals/services/store_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';

class StoreItemViewModel extends BaseViewModel {
  StoreService _storeService = locator<StoreService>();
  NetworkConfig _networkConfig = new NetworkConfig();
  DialogService _dialogService = locator<DialogService>();

  String getContentType(String type) {
    print(type);
    return type;
  }

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
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "Item Purchased",
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
      await _dialogService.showDialog(
        buttonTitle: "Ok",
        description: "${apiResponse['status']}",
        title: "Item Purchased.",
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
}
