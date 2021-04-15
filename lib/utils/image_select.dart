import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/widgets/button.dart';

mixin ImageSelect {
  Completer<File> _dialogCompleter = Completer<File>();
  final picker = ImagePicker();
  File image;
  Future<File> select(BuildContext context) async {
    _showImageSelectionDialog(context);
    print(0333);
    return _dialogCompleter.future;
    // image;
  }

  Future _getImage(source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      print(000);
      image = File(pickedFile.path);
    }
    image = null;
    _dialogCompleter.complete(image);
  }

  _showImageSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kScaffoldColor,
          title: Text("Select photo from"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultButtonBorderedIcon(
                    icon: Icons.perm_media,
                    press: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    text: "Gallery"),
                Padding(padding: EdgeInsets.all(8.0)),
                DefaultButtonBorderedIcon(
                    icon: Icons.camera_alt,
                    press: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    text: "Camera"),
              ],
            ),
          ),
        );
      },
    );
  }
}
