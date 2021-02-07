import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/constants/base_url.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  final Client _client = Client();
  String _userEmail = "";
  String get userEmail => _userEmail;
  UserModel _userModel;
  UserModel get userModel => _userModel;
  List<int> _otpCode;
  List<int> get otpCode => _otpCode;
  generateOtp() {
    Random rand = new Random.secure();
    List<int> _otpCode = List<int>.generate(5, (i) => rand.nextInt(10));
    notifyListeners();
  }

  Future<ApiResponse> checkEmail({@required String email}) async {
    try {
      generateOtp();
      print(_otpCode[0]);
      Response response = await _client.post(
        "${AppUrl.sendEmailToRegister}",
        headers: headers,
        body: {
          "email": email,
          "code": int.tryParse(
              "${_otpCode[0]}${_otpCode[1]}${_otpCode[2]}${_otpCode[3]}${_otpCode[4]}"),
        },
      );
      if (response.statusCode == 201) {
        _userEmail = email;
        notifyListeners();
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> pushOtpCode({@required List<int> code}) async {
    if (code == _otpCode) {
      return ApiResponse.Success;
    } else {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> createPassword({@required String password}) async {
    try {
      Response response = await _client.post(
        "$baseUrl/rest-auth/registration/",
        headers: headers,
        body: {
          "email": _userEmail,
          "password1": password,
          "password2": password,
        },
      );
      if (response.statusCode == 201) {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      Response response = await _client.post(
        "${AppUrl.login}",
        headers: headers,
        body: {
          "email": email,
          "password": password,
        },
      );
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode == 201) {
        // decode data, get token and save to shared prefs
        _saveDataLocally(decodedData);
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      return ApiResponse.Error;
    }
  }

  _getDataFromPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var prefsData = sharedPrefs.getString("userData");
    _userModel = jsonDecode(prefsData);
    notifyListeners();
  }

  _saveDataLocally(data) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(
      "userData",
      jsonEncode(
        UserModel.fromJson(data),
      ),
    );
  }

  Future<bool> autoLogin() async {
    try {
      SharedPreferences sharePrefrences = await SharedPreferences.getInstance();
      if (sharePrefrences.containsKey("userData")) {
        _getDataFromPrefs();
        return true;
      } else {
        print("No User Data was saved");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
