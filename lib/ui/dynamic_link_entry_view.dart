import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dynamic_link_entry_view_model.dart';

class DynamicLinkEntryView extends StatelessWidget {
  final String contentId;
  final String contentType;

  const DynamicLinkEntryView({
    Key key,
    @required this.contentId,
    @required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DynamicLinkEntryViewModel>.nonReactive(
      viewModelBuilder: () => DynamicLinkEntryViewModel(),
      onModelReady: (model) => model.getPost(contentId, contentType),
      builder: (context, model, _) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Fetching Content..."),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
