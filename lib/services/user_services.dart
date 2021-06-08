import 'dart:convert';

import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/models/daily_scripture.dart';
import 'package:jals/utils/network_utils.dart';

class UserServices {
  final NetworkConfig _networkConfig = NetworkConfig();
  final Client _client = Client();

  Future<List<ContentModel>> getExplore() async {
    try {
      List<ContentModel> contents = [];
      Response response = await _client.get(
        AppUrl.Explore,
        headers: appHttpHeaders(),
      );
      print(AppUrl.Explore);
      print(appHttpHeaders());
      var result = json.decode(response.body);
      print(result);
      if (await _networkConfig.isResponseSuccessBool(
        response: result,
      )) {
        result["data"].forEach((event) {
          contents.add(ContentModel().fromJson(event));
        });
        return contents;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ContentModel>> getForYou() async {
    try {
      List<ContentModel> contents = [];
      Response response = await _client.get(
        AppUrl.ForYou,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      print(result);
      if (await _networkConfig.isResponseSuccessBool(
        response: result,
      )) {
        result["data"].forEach((event) {
          contents.add(ContentModel().fromJson(event));
        });
        return contents;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DailyScriptureModel> dailyScripture() async {
    try {
      DailyScriptureModel _dailyScripture;
      Response response = await _client.get(AppUrl.DailyRead);
      var result = json.decode(response.body);
      if (await _networkConfig.isResponseSuccessToast(
        response: result,
      )) {
        _dailyScripture = DailyScriptureModel.fromJson(result);
        return _dailyScripture;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendFeedback(String content) async {
    try {
      Response response = await _client.post(
        AppUrl.Feedback,
        body: {"content": content},
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      return await _networkConfig.isResponseSuccessToast(
        response: result,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> emailNotificationToggle(String content) async {
    try {
      Response response = await _client.get(
        AppUrl.EmailNotificationToggle,
        headers: appHttpHeaders(),
      );
      var result = json.decode(response.body);
      return await _networkConfig.isResponseSuccessToast(
        response: result,
      );
    } catch (e) {
      return false;
    }
  }
}
