import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import '../models/dialog_models.dart';
import '../services/dialog_service.dart';

import '../utils/locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              // backgroundColor: kScaffoldColor,
              title: Text(request.title),
              content: Text(
                request.description,
                // style: TextStyle(color: kTextColor),
              ),
              actions: <Widget>[
                if (isConfirmationDialog)
                  FlatButton(
                    child: Text(request.cancelTitle),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                FlatButton(
                  child: Text(request.buttonTitle),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ));
  }
}
