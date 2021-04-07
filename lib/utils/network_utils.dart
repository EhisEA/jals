import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../services/dialog_service.dart';

import 'locator.dart';

class NetworkConfig {
  final DialogService _dialogService = locator<DialogService>();

// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
  //checking if network call was successful
  Future<bool> isResponseSuccess(
      {@required response, @required String errorTitle}) async {
    // check if the rsponese is null
    if (response != null) {
      // checking is the response is an error
      if (response["status"] == "error") {
        String errorMsg;
        //1242  2688
        // checking is error maessage is a list or just a string
        // if it's a list it would display the first massage
        // else just the error massage

        // print(response["error"].toList()[0]);
        if (response["message"] is List || response["error"] is List) {
          errorMsg = response["message"] != null
              ? response["message"][0]??"Something went wrong"
              : response["error"][0]??"Something went wrong";
        } else if (response["message"] is Map || response["error"] is Map) {
          Map message = response["message"] != null
              ? response["message"]
              : response["error"];
          if (message.values.toList()[0] is List) {
            errorMsg = message.values.toList()[0][0];
          } else {
            errorMsg = message.values.toList()[0];
          }
        } else {
          errorMsg = response["message"] ?? response["error"];
        }
        await _dialogService.showDialog(
          title: '$errorTitle',
          description: '$errorMsg',
        );
        // return false to indicate it was an error
        return false;
      } else if (response["status"] == "successful") {
        // return true to indicate the response status is success
        return true;
      }
    }
    await _dialogService.showDialog(
      title: '$errorTitle',
      description: 'Network Error',
    );
    return false;
  }


  //checking if network call was successful
  Future<bool> isResponseSuccessBool(
      {@required response}) async {
    // check if the rsponese is null
    if (response != null) {
      // checking is the response is an error
      if (response["status"] == "error") {
        // return false to indicate it was an error
        return false;
      } else if (response["status"] == "successful") {
        // return true to indicate the response status is success
        return true;
      }
    }
    return false;
  }

//checking if network call was successful
  Future<bool> isResponseSuccessToast({@required response}) async {
    // check if the rsponese is null
    if (response != null) {
      // checking is the response is an error
      if (response["status"] == "error") {
        String errorMsg;
        //1242  2688
        // checking is error maessage is a list or just a string
        // if it's a list it would display the first massage
        // else just the error massage
        if (response["message"] is List) {
          errorMsg = response["message"][0];
        } else {
          errorMsg = response["message"];
        }
        await Fluttertoast.showToast(msg: "$errorMsg");
        // return false to indicate it was an error
        return false;
      } else if (response["status"] == "successful") {
        // return true to indicate the response status is success
        return true;
      }
    }
    await Fluttertoast.showToast(msg: "Something went wrong");
    return false;
  }

// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
  // check if the device has a network connection
  _networkAvailable() async {
    try {
      // make a call to google to
      var result = await http.get('https://www.google.com');

      // if there is a result return true to indicate there is a connection
      if (result.statusCode == 200) {
        return true;
      }
    } catch (_) {
      // return false if there is no result to indicate
      // there is no network
      return false;
    }
    return false;
  }

// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
  // run a function if there is network or display
  // a dialog showing there is no network conection
  Future onNetworkAvailabilityDialog(Function onNetwork) async {
    // if network  is available run the function [onNetwork]
    if (await _networkAvailable()) {
      await onNetwork();
    } else {
      // if network isn't available show a dialog
      await _dialogService.showDialog(
        title: 'No network connection',
        description: 'Please connect to the internet',
      );
    }
  }

// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
// =================================================
  // run a function if there is network or display
  // a toast showing there is no network conection
  Future onNetworkAvailabilityToast(Function onNetwork) async {
    if (await _networkAvailable()) {
      // if network  is available run the function [onNetwork]
      await onNetwork();
    } else {
      // if network isn't available show a Toast
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  onNetworkAvailabilityBool() async {
    if (await _networkAvailable()) {
      // if network  is available run the function [onNetwork]
      return true;
    } else {
      // if network isn't available return boolean
      return false;
    }
  }
}
//  {status: error, message: {message: A user with this email already exists}}
// {status: error, message: {non_field_errors: [Unable to log in with provided credentials.]}}
