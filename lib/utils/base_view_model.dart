import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ViewState { Busy, Idle }

class BaseViewModel extends ChangeNotifier {
  // final AuthenticationService _authenticationService =
  //     locator<AuthenticationService>();

  // UserModel get currentUser => _authenticationService.currentUser;

  ViewState _state = ViewState.Idle;
  final moneyFormat = NumberFormat('#,###,###,###.00', 'en_US');

  ViewState get state => _state;
  bool get isBusy => _state == ViewState.Busy;

  setBusy(ViewState currentState) {
    _state = currentState;
    notifyListeners();
  }
}
