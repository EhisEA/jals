import 'package:flutter/cupertino.dart';
import 'package:jals/ui/audio/view_model/audio_all_view_model.dart';
import 'package:stacked/stacked.dart';

class AudioDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AudioAllViewModel>.reactive(
        // onModelReady: (model) => model.getAudio,
        viewModelBuilder: () => AudioAllViewModel(),
        builder: (context, model, _) {
          return Center(
            child: Text("Working on it"),
          );
        });
  }
}
