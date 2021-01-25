import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jals/constants/base_url.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  final Client _client = Client();
  final String userData = "userData";
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;
  String _authEmail;
  String get authEmail => _authEmail;
  DateTime _expiryDate;
  bool get isAuthenticated => _authToken != null;
  Timer _timer;
  String _authToken = "";
  String get authToken {
    if (_authToken != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _authToken;
    }
    return null;
  }

// ============================****SignUp with Email****=================================
  Future<ApiResponse> sendSignUpEmail(String email) async {
    try {
      Response response = await _client.post(
        "$baseUrl/registration/",
        body: {"email": email},
        headers: headers,
      );
      if (response.statusCode == 201) {
        _authEmail = email;
        notifyListeners();
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      return ApiResponse.Error;
    }
  }
// =-==========================***Send Password to Register**8=================

  Future<ApiResponse> sendPasswordToRegister(String password) async {
    try {
      Response response = await _client.post(
        "$baseUrl/password/reset/confirm/",
        body: {"": password},
        headers: headers,
      );
      if (response.statusCode == 201) {
        //! Perform Operation.
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

// =====================***Login with Emaiol Address***====================
  Future<ApiResponse> loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      Response response = await _client.post("$baseUrl/login",
          body: {"email": email, "password": password}, headers: {});
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode == 200) {
        print("Login was successful");
        // _currentUser=... && authToken
        _expiryDate = DateTime.now().add(Duration(hours: 10));
        _autoLogout();
        notifyListeners();
        // !Save token to the device.
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final myData = {
          "token": "",
          "expiryDate": _expiryDate.toIso8601String()
        };
        await preferences.setString(userData, jsonEncode(myData));

        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

// ========================================****Verify SignUp Email****===============================
  Future<ApiResponse> verifySignUpEmail(String code) async {
    try {
      Response response = await _client.post(
        "$baseUrl/registration/verify-email/",
        body: {
          "key": code,
        },
      );
      if (response.statusCode == 201) {
        print("Registering to JALS was successful");
        // _currentUser=... && authToken
        _expiryDate = DateTime.now().add(Duration(hours: 10));
        _autoLogout();
        notifyListeners();
        // !Save token to the device.
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final myData = {
          "token": "",
          "expiryDate": _expiryDate.toIso8601String()
        };
        await preferences.setString(userData, jsonEncode(myData));

        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  // ======================================****LogOut****==================
  void logOut() async {
    _authToken = null;
    _expiryDate = null;
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    notifyListeners();
    // ! clear the token from the device.
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }

// ==========================****Auto Logout****=====================
  void _autoLogout() async {
    if (_timer != null) {
      _timer.cancel();
    }
    final int timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _timer = Timer(Duration(seconds: timeToExpiry), _autoLogout);
    //!???
    notifyListeners();
  }

  // ======================****Auto Login****=============
  Future<bool> autoLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final prefsData = preferences.getString(userData);
      final decodedData = jsonDecode(prefsData);
      final timeToExpire = DateTime.parse(decodedData["expiryDate"]);
      if (!preferences.containsKey(userData)) {
        return false;
      }

      if (timeToExpire.isBefore(DateTime.now())) {
        return false;
      }
      _authToken = decodedData["token"];
      _expiryDate = timeToExpire;
      notifyListeners();
      _autoLogout();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // ======================****Forgot Password****==============

  Future<ApiResponse> forgotPassword(String email) async {
    try {
      Response response = await _client.post(
        baseUrl,
      );
      if (response.statusCode == 200) {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }
  // =================****Send Password Verification Code****...====================

  Future<ApiResponse> forgotPasswordVerificationCode(String code) async {
    try {
      Response response = await _client.post(
        baseUrl,
      );
      if (response.statusCode == 200) {
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }
}
