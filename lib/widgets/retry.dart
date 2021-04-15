import 'package:flutter/material.dart';
import 'package:jals/utils/text.dart';

class Retry extends StatelessWidget {
  final Function onRetry;

  const Retry({Key key, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onRetry,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh),
            TextCaption2(
              fontSize: 20,
              text: "Retry",
            ),
          ],
        ),
      ),
    );
  }
}
