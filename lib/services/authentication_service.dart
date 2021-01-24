import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> signUp(String firstName, String lastName, String email,
      String phone, String password) async {
    String url = 'https://cloudmallng.com/api/user/register';

    try {
      http.Response response = await http.post(url, body: {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'phone': phone,
        'password': password,
      });

      if (response.statusCode != 200) {
        //Throw an exception to signify that an error not related to network occurred.

      }

      final decodedData = jsonDecode(response.body);
      _token = decodedData['token'];
      _expiryDate = DateTime.now().add(Duration(hours: 3));
      _autoLogout();

      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final userData = json
          .encode({'token': _token, 'expiry': _expiryDate.toIso8601String()});
      await prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    String url = 'https://cloudmallng.com/api/user/login';
    try {
      http.Response response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['message']);
      }

      final decodedData = jsonDecode(response.body);
//            print(decodedData);
      _token = decodedData['token'];
      _expiryDate = DateTime.now().add(Duration(hours: 3));
      _autoLogout();
      notifyListeners();

//            Store the token on the device
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final userData = json
          .encode({'token': _token, 'expiry': _expiryDate.toIso8601String()});
      await prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  void logout() async {
    _token = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    // Clear the data stored in the sharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<bool> autoLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      final expiryDate = DateTime.parse(extractedUserData['expiry']);

      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }

      _token = extractedUserData['token'];
      _expiryDate = expiryDate;

      notifyListeners();

      _autoLogout();

      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
