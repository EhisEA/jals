import 'package:flutter/material.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';

import '../../../route_paths.dart';

class PlayListWidget extends StatelessWidget {
  final PlayListModel playList;
  final NavigationService _navigationService = locator<NavigationService>();
  final Function onDelete, onEdit;
  final _navigationSrevice = locator<NavigationService>();
  PlayListWidget(this.playList, {Key key, this.onDelete, this.onEdit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigationSrevice.navigateTo(AudioPlaylistViewRoute,
            argument: playList);
      },
      child: Container(
        color: playList.color != null
            ? playlistColors[playList.color]
            : kPrimaryColor,
        padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextCaptionWhite(
                    text: playList.title,
                    fontSize: 16,
                    maxLine: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PopupMenuButton(
                  padding: EdgeInsets.all(0),

                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  // color: kScaffoldColor,
                  onSelected: (value) {
                    switch (value.toString().toLowerCase()) {
                      case "delete":
                        onDelete();
                        break;
                      case "edit":
                        onEdit();
                        break;
                      case "play":
                        _navigationService.navigateTo(AudioPlayerViewRoute,
                            argument: {
                              "audios": playList.tracks,
                              "playlistName": playList.title
                            });
                        break;
                      default:
                    }
                  },
                  // onSelected: (value) => model.showReportDialog(context),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    if (playList.count >= 1)
                      PopupMenuItem(
                        value: "Play",
                        child: Text("Play"),
                      ),
                    const PopupMenuItem(
                      value: "Edit",
                      child: Text("Edit Playlist"),
                    ),
                    const PopupMenuItem(
                      value: "Delete",
                      child: Text("Delete Playlist"),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            TextCaptionWhite(
              text: "${playList.count} Songs",
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
