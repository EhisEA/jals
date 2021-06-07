import 'package:flutter/material.dart';
import 'package:jals/services/user_services.dart';
import 'package:jals/utils/base_view_model.dart';

class FeedbackViewModel extends BaseViewModel {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  UserServices _userServices = UserServices();
  bool feedbackSent = false;

  sendFeedback() async {
    setBusy(ViewState.Busy);
    if (form.currentState.validate())
      feedbackSent = await _userServices.sendFeedback(controller.text);
    setBusy(ViewState.Idle);
  }
}
