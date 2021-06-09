import 'dart:async';

import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/locator.dart';

class DayDisplayViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  get userFullName => _authenticationService.currentUser.fullName ?? "Friend";
  bool get isEvening => greetingText.toLowerCase() == "evening";
  bool get isAfternoon => greetingText.toLowerCase() == "afternoon";
  bool get isMorning => greetingText.toLowerCase() == "morning";
  bool day = false;
  String greetingText;
  Timer _timer;
  @override
  dispose() {
    _timer.cancel();
    super.dispose();
  }

  startTimer() {
    _greeting();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _greeting();
    });
  }

  void _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 6) {
      day = false;
      greetingText = 'Morning';
    } else if (hour < 12) {
      day = true;
      greetingText = 'Morning';
    } else if (hour < 16) {
      day = true;
      greetingText = 'Afternoon';
    } else if (hour < 19) {
      day = true;
      greetingText = 'Evening';
    } else {
      day = false;
      greetingText = 'Evening';
    }
    setBusy(ViewState.Idle);
  }
}
