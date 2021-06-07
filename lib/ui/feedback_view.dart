import 'package:flutter/material.dart';
import 'package:jals/ui/feedback_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/extended_text_field.dart';
import 'package:stacked/stacked.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedbackViewModel>.reactive(
        viewModelBuilder: () => FeedbackViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              leading: BackIcon(),
              title: TextHeader(
                text: "Feedback",
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: model.form,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: model.feedbackSent
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                // mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: kGreen,
                                    size: 150,
                                  ),
                                  SizedBox(height: 10),
                                  TextCaption2(
                                    text: "Your feedback was sent",
                                    fontSize: 20,
                                  ),
                                  SizedBox(height: 100),
                                  DefaultButtonBordered(
                                    press: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: "Okay",
                                    color: kGreen,
                                  )
                                ],
                              ),
                            ),
                          )
                        : model.isBusy
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView(
                                children: [
                                  // SizedBox(height: 50),
                                  TextHeader3(
                                    text: "Your opinion matters",
                                    fontSize: 30,
                                  ),
                                  SizedBox(height: 10),
                                  TextCaption2(
                                    text: "Please tell us how you feel about "
                                        "the app and what you would like us "
                                        "to add or improve on",
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                  SizedBox(height: 50),
                                  ExtendedTextField(
                                    title: "Feedback",
                                    controller: model.controller,
                                    multiline: true,
                                    validator: (value) {
                                      if (value.length <= 8) {
                                        return "You must write a reasonable length of feedback";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 50),
                                  DefaultButton(
                                    onPressed: model.sendFeedback,
                                    title: "Send Feedback",
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
