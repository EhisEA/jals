import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/ui/audio/view_model/audio_all_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/audio_tile.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class AudioAll extends StatefulWidget {
  @override
  _AudioAllState createState() => _AudioAllState();
}

class _AudioAllState extends State<AudioAll>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<AudioAllViewModel>.reactive(
      onModelReady: (model) {
        if (!model.isBusy && model.audioList == null) {
          model.getAudio();
        } else if (!model.isBusy && model.audioList.isEmpty) {
          model.getAudio();
        }
      },
      viewModelBuilder: () => locator<AudioAllViewModel>(),
      disposeViewModel: false,
      builder: (context, model, _) {
        return model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.audioList == null
                ? Retry(
                    onRetry: model.getAudio,
                  )
                : RefreshIndicator(
                    onRefresh: model.getAudio,
                    child: ListView(
                      children: List.generate(
                        model.audioList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: AudioTile(
                            audio: model.audioList[index],
                            purchaseCallback: () => model.purchaseAudio(index),
                            popOption: ["Share"],
                            onOptionSelect: (value) => model.onOptionSelect(
                              value,
                              model.audioList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
