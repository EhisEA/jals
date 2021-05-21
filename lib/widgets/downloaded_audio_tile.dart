import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/audio_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';

import '../route_paths.dart';

class DownloadedAudioTile extends StatelessWidget {
  final AudioModel audio;
  final List<String> popOption;
  final Function(dynamic) onOptionSelect;
  final _navigationService = locator<NavigationService>();
  DownloadedAudioTile(
      {Key key, this.audio, this.popOption: const [], this.onOptionSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        if (audio.isPurchased == false && audio.price > 0) {
          _navigationService.navigateTo(StoreItemViewRoute,
              argument: audio.toContent());
        } else {
          _navigationService.navigateTo(AudioPlayerViewRoute, argument: {
            "audios": [audio],
            "playlistName": null
          });
        }
      },
      child: Row(
        children: [
          Container(
            height: getProportionatefontSize(60),
            width: getProportionatefontSize(60),
            child: AspectRatio(
              aspectRatio: 1,
              child: ShowNetworkImage(imageUrl: audio.artUri),
            ),
          ),
          Expanded(
            child: ListTile(
              title: TextTitle(
                text: "${audio.title}",
                maxLines: 2,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCaption(
                      text: "${audio.author}",
                    ),
                    // SizedBox(height: 5),
                    TextCaption(
                      text:
                          "Downloaded ${DateFormat(" dd/MM/yyyy").format(audio.downloadDate)}",
                    ),
                  ],
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
}
