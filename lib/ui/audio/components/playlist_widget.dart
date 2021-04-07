import 'package:flutter/material.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

import '../../../route_paths.dart';

class PlayListWidget extends StatelessWidget {
  final PlayListModel playList;
  final Function onDelete;
  final _navigationSrevice = locator<NavigationService>();
  PlayListWidget(this.playList, {Key key, this.onDelete}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigationSrevice.navigateTo(AudioPlaylistViewRoute,
            argument: playList);
      },
      child: Container(
        color: kPrimaryColor,
        padding: const EdgeInsets.fromLTRB(20.0,20,0,20),
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
                  onSelected: (value)=>onDelete(),
                  // onSelected: (value) => model.showReportDialog(context),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      
                      value: "Delete Playlist",
                      child: Text("Delete Playlist"),
                    ),
                  ],
                ),
              //   Icon(
              //     Icons.more_vert,
              //     color: Colors.white,
              //   ),
              ],
            ),
            SizedBox(
              height: getProportionatefontSize(10),
            ),
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
