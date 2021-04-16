import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/comment_author.dart';
import 'package:jals/models/comment_model.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/comment_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';

import '../extended_text_field.dart';

class CommentWidgetViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _authenticationService = locator<AuthenticationService>();
  final TextEditingController commentController = TextEditingController();
  final CommentService _commentService = CommentService();
  String contentId;
  List<CommentModel> comments;
  List<CommentModel> recentComments = [];

  CommentWidgetViewModel(String id) {
    contentId = id;
    getComments();
  }
  getComments() async {
    setBusy(ViewState.Busy);
    comments = await _commentService.getComments(contentId);
    setBusy(ViewState.Idle);
  }

  Future<void> sendComment() async {
    setSecondaryBusy(ViewState.Busy);
    bool response =
        await _commentService.postComment(contentId, commentController.text);
    if (response) {
      Fluttertoast.showToast(
        msg: "Your Comment has been posted",
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
      );
      //add to recent comment so as to display on screen
      recentComments.add(
        CommentModel(
          comment: commentController.text,
          commentAuthor: CommentAuthor(
            avatarThumbnail: _authenticationService.currentUser.avatar,
            fullName: _authenticationService.currentUser.fullName,
          ),
          date: DateTime.now(),
          post: "",
        ),
      );
      commentController.clear();
      print(recentComments.length);
    } else {
      Fluttertoast.showToast(
        msg: "Your Comment was not posted: try again",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    setSecondaryBusy(ViewState.Idle);
  }

  writeComment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Container(
          // width: double.infinity,

          ///this allows bottom sheet to display above the keyboard
          height: MediaQuery.of(context).size.height / 2 +
              MediaQuery.of(context).viewInsets.bottom,
          padding: const EdgeInsets.all(20.0),
          child: isSecondaryBusy
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(child: TextHeader(text: "Comment")),
                        SizedBox(height: 20),
                        TextCaption(text: "Comment"),
                        SizedBox(height: 10),
                        ExtendedTextField(
                          title: "Comment",
                          controller: commentController,
                          multiline: true,
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sendComment().then((value) {
                                setState(() {});
                              });
                            });
                          },
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 10,
                              ),
                              child: TextCaptionWhite(
                                text: "Post Comment",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
