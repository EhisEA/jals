import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jals/models/comment_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/view_models/comment_widget_view_model.dart';
import 'package:stacked/stacked.dart';

class CommentWidget extends StatelessWidget {
  final CommentWidgetViewModel commentWidgetViewModel;

  const CommentWidget({Key key, @required this.commentWidgetViewModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentWidgetViewModel>.reactive(
      viewModelBuilder: () => commentWidgetViewModel,
      disposeViewModel: false,
      builder: (context, model, _) {
        print(model.recentComments.length);
        print('===');
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextComment(
                  text:
                      "Comment ${model.comments == null ? 0 : model.comments.length + model.recentComments.length}",
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.recentComments.length,
              itemBuilder: (context, index) {
                CommentModel comment = model.recentComments[index];
                print(
                    model.recentComments[index].commentAuthor.avatarThumbnail);
                return ListTile(
                  leading: model.recentComments[index].commentAuthor
                              .avatarThumbnail ==
                          null
                      ? CircleAvatar(
                          radius: 15,
                          child: Center(
                              child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 15,
                          )),
                        )
                      : ClipOval(
                          child: Container(
                              height: 35,
                              width: 35,
                              child: ShowNetworkImage(
                                imageUrl: model.recentComments[index]
                                    .commentAuthor.avatarThumbnail,
                              )),
                        ),
                  title: TextCaption2(
                    text: comment.comment,
                  ),
                );
              },
            ),
            model.isBusy
                ? Center(child: CircularProgressIndicator())
                : model.comments == null
                    ? IconButton(
                        icon: Icon(
                          Icons.wifi_protected_setup_rounded,
                          color: kTextColor.withOpacity(0.9),
                        ),
                        onPressed: () => model.getComments())
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.comments.length,
                        itemBuilder: (context, index) {
                          CommentModel comment = model.comments[index];
                          return ListTile(
                            leading: model.comments[index].commentAuthor
                                        .avatarThumbnail ==
                                    null
                                ? CircleAvatar(
                                    backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    radius: 15,
                                    child: Center(
                                        child: Icon(Icons.person,
                                            color: Colors.white)),
                                  )
                                : ClipOval(
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        child: ShowNetworkImage(
                                          imageUrl: model.comments[index]
                                              .commentAuthor.avatarThumbnail,
                                        )),
                                  ),
                            title: TextCaption2(
                              text: comment.comment,
                            ),
                          );
                        },
                      ),
          ],
        );
      },
    );
  }
}
