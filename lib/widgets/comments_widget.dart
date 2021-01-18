import 'package:flutter/material.dart';
import 'package:jals/utils/text.dart';

class CommentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              text: "Comment 49",
            ),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 15,
          ),
          title: TextCaption2(
            text: "Amet minim mollit non deserunt ullamco ....",
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 15,
          ),
          title: TextCaption2(
            text: "Amet minim mollit non deserunt ullamco ....",
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 15,
          ),
          title: TextCaption2(
            text: "Amet minim mollit non deserunt ullamco ...."
                "Amet minim mollit non deserunt ullamco ...."
                "Amet minim mollit non deserunt ullamco ...."
                "Amet minim mollit non deserunt ullamco ....",
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 15,
          ),
          title: TextCaption2(
            text: "Amet minim mollit non deserunt ullamco ....",
          ),
        )
      ],
    );
  }
}
