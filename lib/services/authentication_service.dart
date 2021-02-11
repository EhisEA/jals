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
  int _otpCode;
  int get otpCode => _otpCode;
  int generateOtp() {
    Random rand = new Random.secure();
    // ignore: unused_local_variable
    List<int> _otp = List<int>.generate(5, (i) => rand.nextInt(10));
    int _otpCode =
        int.tryParse("${_otp[0]}${_otp[1]}${_otp[2]}${_otp[3]}${_otp[4]}");
    notifyListeners();
    return _otpCode;
  }

  Future<ApiResponse> checkEmail({@required String email}) async {
    try {
      generateOtp();
      print(_otpCode);
      Response response = await _client.post(
        "${AppUrl.sendEmailToRegister}",
        headers: headers,
        body: {
          "email": email,
          "code": _otpCode,
        },
      );
      if (response.statusCode == 200) {
        _userEmail = email;
        notifyListeners();
        print(_userEmail);
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> pushOtpCode({@required String code}) async {
    print(code);
    print(code);
    print(code);
    print(code);
    print(code);
    if (code == _otpCode.toString()) {
      return ApiResponse.Success;
    } else {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> createPassword({@required String password}) async {
    try {
      Response response = await _client.post(
        "${AppUrl.sendRegistrationPassword}",
        headers: headers,
        body: {
          "email": _userEmail,
          "password1": password,
          "password2": password,
        },
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData["status"]);
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
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData["status"]);
      print(decodedData["data"]["key"]);
      if (response.statusCode == 200) {
        // decode data, get token and save to shared prefs

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

  Future<ApiResponse> createUserAccountIfno(
      {String userName,
      String dateOfBirth,
      String phoneNumber,
      String avatarUrl}) async {
    try {
      Response response = await _client.post("${AppUrl.createUserAccountIno}",
          headers: headers,
          body: {
            "user_name": userName,
            "date_of_birth": dateOfBirth,
            "phone_number": phoneNumber
          });
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode == 201) {
        return ApiResponse.Success;
      }
      return ApiResponse.Error;
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
