import 'package:flutter/material.dart';

class NewestItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}