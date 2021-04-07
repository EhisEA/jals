import 'package:flutter/material.dart';
import 'package:jals/ui/audio/components/playlist_widget.dart';
import 'package:jals/ui/audio/view_model/audio_playlist_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:stacked/stacked.dart';


class AudioPlaylist extends StatefulWidget {
  @override
  _AudioPlaylistState createState() => _AudioPlaylistState();
}

class _AudioPlaylistState extends State<AudioPlaylist>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlaylsitViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => AudioPlaylsitViewModel(),
        onModelReady: (model) => model.getPlaylist(),
        builder: (context, model, _) {
          return model.isBusy
              ? Center(child: CircularProgressIndicator())
              : model.playList == null
                  ? Center(
                      child: IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: model.getPlaylist))
                  : Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showBottomSheet(context, model);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryColor),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            TextArticle(text: "Create Playlist"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: GridView.count(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 156 / 112,
                            shrinkWrap: true,
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 550 ? 3 : 2,
                            children: List.generate(
                              model.playList.length,
                              (index) => PlayListWidget(
                                model.playList[index],
                                onDelete: () => model.onDelete(index),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
        });
  }

  showBottomSheet(BuildContext context, AudioPlaylsitViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ViewModelBuilder<AudioPlaylsitViewModel>.reactive(
            viewModelBuilder: () => viewModel,
            disposeViewModel: false,
            builder: (context, model, _) {
              return model.isSecondaryBusy
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child:
                                  TextHeader(text: "Customize your playlist")),
                          SizedBox(height: 20),
                          TextCaption(text: "Enter Name Of Playlist"),
                          SizedBox(height: 10),
                          Form(
                            key: model.formKey333,
                            child: TextFormField(
                              controller: model.playlistNameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "You must enter a playlist name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextCaption(text: "Choose Mood Color"),
                          SizedBox(height: 10),
                          GridView.extent(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            maxCrossAxisExtent: 40,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            children: List.generate(
                              playlistColors.length,
                              (index) => InkWell(
                                onTap: () => model.changeMoodColorIndex(index),
                                child: CircleAvatar(
                                  backgroundColor: playlistColors[index],
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 400),
                                    child: model.moodColorIndex == null ||
                                            model.moodColorIndex != index
                                        ? SizedBox(
                                            key: Key("22"),
                                          )
                                        : Icon(
                                            Icons.check,
                                            key: Key("34"),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              model.createPlaylist();
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kPrimaryColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 10,
                                ),
                                child: TextCaptionWhite(
                                  text: "Create Playlist",
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
