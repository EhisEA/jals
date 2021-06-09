import 'dart:convert';

import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/content_model.dart';

class StoreService {
  Client _client = new Client();
  Future<List<ContentModel>> getNewestStoreItems(
      {DateTime th, DateTime tl}) async {
    try {
      String url;
      if (th != null && th != null) {
        int thInt = th.millisecondsSinceEpoch;
        int tlInt = tl.millisecondsSinceEpoch;

        url = AppUrl.fetchNewestStoreItems + "?th=$thInt&tl=$tlInt";
      } else {
        url = AppUrl.fetchNewestStoreItems;
      }

      Response response = await _client.get(
        url,
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);

      if (decodedData["status"] == "successful") {
        List<ContentModel> listOfItems = [];

        decodedData["data"]["results"].forEach((e) {
          listOfItems.add(ContentModel().fromJson(e));
        });
        return listOfItems;
      } else {
        return null;
      }
    } catch (e) {
      print("The error  fetching the newest items from store was $e");
      return null;
    }
  }

  // =======Get Purchased Store Items==========
  Future<List<ContentModel>> getPurchasedItemsList() async {
    try {
      Response response = await _client.get(
        AppUrl.getPurchasedItemsList,
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData["status"] == "successful") {
        List<ContentModel> listOfItems = [];

        decodedData["data"]["results"].forEach((e) {
          listOfItems.add(ContentModel().fromJson(e));
        });
        return listOfItems;
      } else {
        return null;
      }
    } catch (e) {
      print("The Error geotten from fetching the list of purchased Items==$e");
      return null;
    }
  }

//=======Buy Video=======
  Future<Map<String, String>> buyVideo(String id) async {
    try {
      Response response = await _client.get(
        AppUrl.videoPay(id),
        headers: appHttpHeaders(),
      );
      print(AppUrl.videoPay(id));
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData['status'] == 'successful') {
        print("Successfully Bought Item");
        return {
          'response': 'Success',
          'status': 'Item Was Purchased Successfully}'
        };
      } else {
        print("Could not purchase item....");
        return {'response': 'Error', 'status': decodedData['error']['message']};
      }
    } catch (e) {
      print(e);
      return {
        'response': 'Error',
        'status': 'An error occured, could not purchase video.  '
            "please try again"
      };
    }
  }

  Future<Map<String, String>> buyAudio(String id) async {
    try {
      Response response = await _client.get(
        AppUrl.buyAudio(id),
        headers: appHttpHeaders(),
      );
      print(AppUrl.buyAudio(id));
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData['status'] == 'successful') {
        print("Successfully Bought Item");
        return {'response': 'Success', 'status': 'Item Purchased Successfully'};
      } else {
        print("Could not purchase item....");
        return {'response': 'Error', 'status': decodedData['error']['message']};
      }
    } catch (e) {
      print(e);
      return {
        'response': 'Error',
        'status': 'An error occured, could not purchase audio.  '
            "please try again"
      };
    }
  }

  Future<Map<String, String>> buySermon(String id) async {
    try {
      Response response = await _client.get(
        AppUrl.buySermon(id),
        headers: appHttpHeaders(),
      );
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData['status'] == 'successful') {
        print("Successfully Bought Item");
        return {
          'response': 'Success',
          'status': 'Item was purchased successfully.'
        };
      } else {
        print("Could not purchase item....");
        return {'response': 'Error', 'status': decodedData['error']['message']};
      }
    } catch (e) {
      print(e);
      return {
        'response': 'Error',
        'status': 'An Error occured, can not purchase item.'
      };
    }
  }

  Future<int> getWalletBalance() async {
    try {
      Response response = await _client.get(
        AppUrl.WALLET_BALANCE,
        headers: appHttpHeaders(),
      );
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      print(decodedData);
      if (decodedData['status'] == 'successful') {
        print(decodedData['data']['coins']);
        return int.parse(decodedData['data']['coins'].toString());
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> creditWallet(int coins) async {
    try {
      Response response = await _client.post(
        AppUrl.CREDIT_WALLET,
        headers: appHttpHeaders(),
        body: {
          "credit": coins.toString(),
        },
      );
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      print(decodedData);
      if (decodedData['status'] == 'successful') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
