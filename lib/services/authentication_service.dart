import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/constants/base_url.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/user_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  final Client _client = Client();
  NavigationService _navigationService = locator<NavigationService>();
  final NetworkConfig _networkConfig = NetworkConfig();
  String _userSignUpEmail = "";
  UserModel _userModel;
  UserModel get userModel => _userModel;
  int _otpCode;
  int get otpCode => _otpCode;

  int generateOtp() {
    Random rand = new Random.secure();
    // ignore: unused_local_variable
    List<int> _generatedOtpCode =
        List<int>.generate(6, (i) => rand.nextInt(10));
    return int.parse(
      "${_generatedOtpCode[0]}${_generatedOtpCode[1]}${_generatedOtpCode[2]}${_generatedOtpCode[3]}${_generatedOtpCode[4]}${_generatedOtpCode[5]}",
    );
  }

  Future<ApiResponse> verifyEmail({@required String email}) async {
    try {
      print("Generating OTP Code....");
      _otpCode = generateOtp();
      print(_otpCode);
      _userSignUpEmail = email;
      Response response = await _client.post(
        "${AppUrl.VerifyEmail}",
        body: {
          "email": email,
          "code": _otpCode.toString(),
        },
      );
      var result = json.decode(response.body);
      print(result);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("There was Success...");
        return ApiResponse.Success;
      } else {
        print("An Error Occured");
        _networkConfig.isResponseSuccess(
            response: result, errorTitle: "Sign Up Failure");
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> validateOtpCode({@required String code}) async {
    if (code == _otpCode.toString()) {
      return ApiResponse.Success;
    } else {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> registerUser({@required String password}) async {
    try {
      Response response = await _client.post(
        "${AppUrl.RegisterUser}",
        body: {
          "email": _userSignUpEmail,
          "password1": password,
          "password2": password,
        },
      );
      print(json.decode(response.body));
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
        "${AppUrl.Login}",
        body: {
          "email": email,
          "password": password,
        },
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      print(decodedData["status"]);
      // print(decodedData);
      if (response.statusCode >= 200 || response.statusCode < 299) {
        print("LOGGING IN WAS SUCCESSFUL");
        // decode data, get token and save to shared prefs
        _userModel = UserModel.fromJson(decodedData);
        notifyListeners();
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setString("userData", "My object"
            // jsonEncode(
            //   UserModel.fromJson(decodedData),
            // ),
            );
        print("Saved The User Object to the SharedPreferences....");
        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      print(" The error was $e");
      return ApiResponse.Error;
    }
  }

  _getDataFromPrefs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var prefsData = sharedPrefs.getString("userData");
    _userModel = jsonDecode(prefsData);
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    try {
      SharedPreferences sharePrefrences = await SharedPreferences.getInstance();
      if (sharePrefrences.containsKey("userData")) {
        print("User Data was Saved ");
        // _getDataFromPrefs();
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
      Response response = await _client.post("${AppUrl.CreateUserAccountIno}",
          headers: headers,
          body: {
            "user_name": userName,
            "date_of_birth": dateOfBirth,
            "phone_number": phoneNumber
          });
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode >= 200 || response.statusCode < 299) {
        return ApiResponse.Success;
      } else {
        _networkConfig.isResponseSuccess(
            response: decodedData, errorTitle: "Account Verification Error");
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> sendForgotPasswordEmail({String email}) async {
    try {
      print("Generating the Otp code...");
      _otpCode = generateOtp();
      print(_otpCode);
      _userSignUpEmail = email;
      Response response = await _client.post(
        "${AppUrl.SendForgotPasswordEmail}",
        headers: headers,
        body: {
          "code": _otpCode,
          "email": email,
        },
      );
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode >= 200 || response.statusCode < 299) {
        print("Success");
        return ApiResponse.Success;
      } else {
        _networkConfig.isResponseSuccess(
            response: decodedData, errorTitle: "Forgot Password Error");
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> sendForgotPassword(String password) async {
    try {
      Response response = await _client.post(
        "${AppUrl.SendForgotPassword}",
        body: {
          "email": _userSignUpEmail,
          "new_password": password,
        },
        headers: headers,
      );
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode >= 200 || response.statusCode < 299) {
        return ApiResponse.Success;
      } else {
        _networkConfig.isResponseSuccess(
            response: decodedData, errorTitle: "Password Update Error");
        return ApiResponse.Error;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Error;
    }
  }

  Future logOut() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      print("Done");
      await _navigationService.navigateToReplace(LoginViewRoute);
      print("Exit 0");
    } catch (e) {
      print(e);
    }
  }
}
// 3b79df4433f5aad10c8956e3bd0fb71e415790a7
