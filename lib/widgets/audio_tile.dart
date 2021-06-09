import 'package:flutter/material.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

import 'image.dart';

class AudioTile extends StatelessWidget {
  final AudioModel audio;
  final Function purchaseCallback;
  final List<String> popOption;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();
  AudioTile({
    Key key,
    this.audio,
    this.popOption: const [],
    this.onOptionSelect,
    this.purchaseCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: openAudio,
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(60),
            width: getProportionatefontSize(60),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(imageUrl: audio.coverImage),
            ),
          ),
          Expanded(
            child: ListTile(
              title: TextTitle(
                text: "${audio.title}",
                maxLines: 2,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: TextCaption(
                  text: "${audio.author}",
                ),
              ),
              trailing: PopupMenuButton(
                padding: EdgeInsets.all(0),

                icon: Icon(
                  Icons.more_vert,
                  // color: Colors.,
                ),
                // color: kScaffoldColor,
                onSelected: (value) => onOptionSelect(value),
                // onSelected: (value) => model.showReportDialog(context),
                itemBuilder: (BuildContext context) => List.generate(
                  popOption.length,
                  (index) => PopupMenuItem(
                    value: "${popOption[index]}",
                    child: Text("${popOption[index]}"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openAudio() {
    if (audio.isPurchased == false && audio.price > 0) {
      _navigationService.navigateTo(StoreItemViewRoute, argument: {
        "content": audio.toContent(),
        "callback": () {
          purchaseCallback();
          openAudio();
        },
      });
    } else {
      _navigationService.navigateTo(AudioPlayerViewRoute, argument: {
        "audios": [audio],
        "playlistName": null
      });
    }
  }
}
