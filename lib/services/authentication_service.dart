import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jals/constants/app_urls.dart';
import 'package:jals/constants/keys.dart';
import 'package:jals/enums/api_response.dart';
import 'package:jals/models/login_status.dart';
import 'package:jals/models/user_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/network_utils.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final Client _client = Client();
  NavigationService _navigationService = locator<NavigationService>();
  final NetworkConfig _networkConfig = NetworkConfig();
  String _userSignUpEmail = "";
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;
  int _otpCode;
  int get otpCode => _otpCode;

  _populateCurrentUser(Map<String, dynamic> user) {
    if (user != null) {
      _currentUser = UserModel.fromJson(user);
      _saveUserLocally();
    }
  }

  _updateCurrentUser(Map<String, dynamic> user) {
    if (user != null) {
      _currentUser =
          UserModel.fromJsonWithToken(_currentUser.key, user["data"]);
      _saveUserLocally();
    }
  }

  _populateCurrentUserFromPref(Map<String, dynamic> user) {
    if (user != null) {
      _currentUser = UserModel.fromMap(user);
      _saveUserLocally();
    }
  }

  // for external data change
  // where this changes occur
  // ====== Edit profile (avatar, username, fullname)
  // ====== view profile (cover image)
  // ====== start up view (refresh user data incase changes where made from another device or from the web app)
  void refreshUserData(Map<String, dynamic> user) {
    if (user != null) {
      _currentUser = UserModel.fromJson(user);

      _saveUserLocally();
    }
  }

  Future<LoginStatus> isUserLoggedIn() async {
    // final UserService _userService = UserService();
    SharedPreferences _preferences;
    _preferences = await SharedPreferences.getInstance();
    String userJsonString = _preferences.getString("userData");

    print(userJsonString);
    if (userJsonString != null) {
      await _populateCurrentUserFromPref(jsonDecode(userJsonString));
      if (_currentUser.isDetailsComplete()) {
        return LoginStatus.LoginComplete;
      }
      return LoginStatus.LoginIncomplete;
    }

    return LoginStatus.NoUser;
  }

  _saveUserLocally() async {
    SharedPreferences _preferences;
    _preferences = await SharedPreferences.getInstance();
    // print(_currentUser.dateOfBirth);
    print("===============");
    print(_currentUser.fullName);
    print(_currentUser.dateOfBirth);
    print(_currentUser.key);
    print(_currentUser.id);

    _preferences.setString("userData", jsonEncode(_currentUser.toJson()));
  }

  //=======================================================================
  //* ============= ++++++++----- Otp generator ----------++++++++ =================
  //=======================================================================

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
      if (response.statusCode >= 200 && response.statusCode < 299) {
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
      var decodedData = json.decode(response.body);
      print(json.decode(response.body));
      if (response.statusCode >= 200 || response.statusCode < 299) {
        _populateCurrentUser(decodedData);

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
      print(decodedData);
      if (response.statusCode >= 200 && response.statusCode < 299) {
        debugPrint("LOGGING IN WAS SUCCESSFUL1");
        // decode data, get token and save to shared prefs
        // _currentUser = UserModel.fromJson(decodedData);
        _populateCurrentUser(decodedData);

        debugPrint("Saved The User Object to the SharedPreferences....");

        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      debugPrint(" The error was $e");
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> loginWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        // Optional clientId
        clientId: Keys.googleClientId,
      );
      GoogleSignInAccount user = await _googleSignIn.signIn();
      GoogleSignInAuthentication authData = await user.authentication;
      if (authData.accessToken == null) return ApiResponse.Error;
      Response response = await _client.post(
        "${AppUrl.GoogleLogin}",
        body: {
          "access_token": authData.accessToken,
        },
      );
      final Map<String, dynamic> decodedData = jsonDecode(response.body);

      _googleSignIn.disconnect();
      if (response.statusCode >= 200 && response.statusCode < 299) {
        _populateCurrentUser(decodedData);

        return ApiResponse.Success;
      } else {
        return ApiResponse.Error;
      }
    } catch (e) {
      debugPrint(" The error was $e");
      return ApiResponse.Error;
    }
  }

  Future<bool> autoLogin() async {
    try {
      SharedPreferences sharePrefrences = await SharedPreferences.getInstance();

      if (sharePrefrences.containsKey("userData")) {
        print("User Data was Saved ");
        print("=============== current users==========1111");
        Map<String, dynamic> decodedData =
            json.decode(sharePrefrences.getString("userData"));
        print(decodedData);
        await _populateCurrentUserFromPref(decodedData);

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

  Future<ApiResponse> createUserAccountInfo({
    String fullName,
    String dateOfBirth,
    String phoneNumber,
    File avatar,
  }) async {
    try {
// ============================================================
      final String url = "${AppUrl.CreateUserAccountInfo}";
      //image is a file variable holdint the selected  image
      final imageUploadRequest = MultipartRequest(
        'POST',
        Uri.parse(url),
      );

      // chack if avatar is not null
      // before adding it to the request
      if (avatar != null) {
        // setting the image typr
        final mimeTypeData =
            lookupMimeType(avatar.path, headerBytes: [0xFF, 0xD8]).split("/");

        // prepare the image
        final file = MultipartFile(
          "avatar",
          File(avatar.path).readAsBytes().asStream(),
          File(avatar.path).lengthSync(),
          filename: avatar.path.split("/").last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        );

        // add the image to the request
        imageUploadRequest.files.add(file);
      }
      imageUploadRequest.headers.addAll(appHttpHeaders());

      // all the if check is to avoid null for being sent to db
      if (fullName != null) {
        imageUploadRequest.fields['full_name'] = fullName;
      }
      if (dateOfBirth != null) {
        imageUploadRequest.fields['date_of_birth'] = dateOfBirth;
      }
      if (phoneNumber != null) {
        imageUploadRequest.fields['phone_number'] = phoneNumber;
      }
      final streamResponse = await imageUploadRequest.send();
      final response = await Response.fromStream(streamResponse);

// ============================================================
      final decodedData = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 299) {
        _updateCurrentUser(decodedData);
        return ApiResponse.Success;
      } else if (response.statusCode == 400) {
        return ApiResponse.Success;
      } else {
        _networkConfig.isResponseSuccess(
            response: decodedData, errorTitle: "Account Verification Error");
        return ApiResponse.Error;
      }
    } catch (e) {
      return ApiResponse.Error;
    }
  }

  Future<ApiResponse> changePassword(
      {String oldPassword, String newPassword}) async {
    try {
      print(oldPassword);
      print(newPassword);
      Response response = await _client.post(
        "${AppUrl.ChangePassword}",
        headers: appHttpHeaders(),
        body: {
          "old_password": oldPassword,
          "new_password": newPassword,
        },
      );
      print(json.decode(response.body));
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode < 299) {
        return ApiResponse.Success;
      } else if (response.statusCode == 400) {
        return ApiResponse.Error;
      } else {
        _networkConfig.isResponseSuccessToast(response: response);
        return ApiResponse.Empty;
      }
    } catch (e) {
      print(e);
      return ApiResponse.Empty;
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
        headers: appHttpHeaders(),
        body: {
          "code": _otpCode,
          "email": email,
        },
      );
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode >= 200 && response.statusCode < 299) {
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
        headers: appHttpHeaders(),
      );
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode >= 200 && response.statusCode < 299) {
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
