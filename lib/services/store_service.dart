import 'dart:convert';

import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/store_model.dart';

class StoreService {
  Client _client = new Client();
  Future<List<StoreModel>> getNewestStoreItems() async {
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
        List<StoreModel> listOfItems = decodedData["data"]["results"]
            .map((e) => StoreModel.fromJson(e))
            .toList();
        return listOfItems;
      } else {
        print("Will return an empty List");
        List<StoreModel> emptyList = [];
        return emptyList;
      }
    } catch (e) {
      print("The error  fetching the newest items from store was $e");
      List<StoreModel> emptyList = [];
      return emptyList;
    }
  }

  // =======Get Purchased Store Items==========
  Future getPurchasedItemsList() async {
    try {
      Response response = await _client.get(AppUrl.getPurchasedItemsList);
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      if (decodedData["status"] == "successful") {
        // Perfom action...
      } else {
        // Perfom another action...
      }
    } catch (e) {
      print("The Error geottn from fetching the list of purchased Items==$e");
    }
  }
}
