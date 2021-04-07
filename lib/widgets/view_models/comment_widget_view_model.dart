import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/comment_author.dart';
import 'package:jals/models/comment_model.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/services/comment_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';

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

  void sendComment() async {
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
    } else {
      Fluttertoast.showToast(
        msg: "Your Comment was not posted: try again",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    setSecondaryBusy(ViewState.Idle);
  }
}
