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
        print("Will return an empty List");
        List<ContentModel> emptyList = [];
        return emptyList;
      }
    } catch (e) {
      print("The error  fetching the newest items from store was $e");
      List<ContentModel> emptyList = [];
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
