import 'dart:convert';

import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/content_model.dart';

class StoreService {
  Client _client = new Client();
  Future<List<ContentModel>> getNewestStoreItems() async {
    try {
      Response response = await _client.get(
        AppUrl.fetchNewestStoreItems,
        headers: appHttpHeaders(),
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData);
      if (decodedData["status"] == "successful") {
        print(
            "======================Success Fetching the list of Newest shop data.===========");
        List<ContentModel> listOfItems = [];

        decodedData["data"]["results"].forEach((e) {
          listOfItems.add(ContentModel().fromJson(e));
        });
        return listOfItems;
      } else {
        print("Will return null");
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
        print(decodedData);
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
      return {'response': 'Error', 'status': 'An Error Occured'};
    }
  }

  Future<Map<String, String>> buyAudio(String id) async {
    try {
      Response response = await _client.get(
        AppUrl.buyAudio(id),
        headers: appHttpHeaders(),
      );
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData['error']['message']);
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
        'status': 'An Error Occured, can not purchase video'
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

  Future<double> getWalletBalance() async {
    try {
      Response response = await _client.get(
        AppUrl.WALLET_BALANCE,
        headers: appHttpHeaders(),
      );
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      if (decodedData['status'] == 'Successful') {
        print(decodedData['data']['coins']);
        return decodedData['data']['coins'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
