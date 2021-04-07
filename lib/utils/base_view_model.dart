import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/enums/small_viewstate.dart';

enum ViewState { Busy, Idle }

class BaseViewModel extends ChangeNotifier {
  // final AuthenticationService _authenticationService =
  //     locator<AuthenticationService>();

  // UserModel get currentUser => _authenticationService.currentUser;

  bool _disposed = false;
  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  ViewState _state = ViewState.Idle;
  final moneyFormat = NumberFormat('#,###,###,###.00', 'en_US');
  SmallViewState _smallViewState = SmallViewState.Done;
  SmallViewState get smallViewState => _smallViewState;
  setSmallViewState(SmallViewState state) {
    _smallViewState = state;
    notifyListeners();
  }

  ViewState get state => _state;
  bool get isBusy => _state == ViewState.Busy;
  bool get isDisposed => _disposed;

  ViewState _secondaryState = ViewState.Idle;

  ViewState get secondaryState => _secondaryState;
  bool get isSecondaryBusy => _secondaryState == ViewState.Busy;

  void setBusy(ViewState currentState) {
    _state = currentState;
    if (!_disposed) notifyListeners();
  }

  setSecondaryBusy(ViewState currentState) {
    _secondaryState = currentState;
    if (!_disposed) notifyListeners();
  }
}
