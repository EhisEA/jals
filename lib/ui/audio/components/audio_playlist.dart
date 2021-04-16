import 'package:flutter/material.dart';
import 'package:jals/ui/audio/components/playlist_widget.dart';
import 'package:jals/ui/audio/view_model/audio_playlist_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class AudioPlaylistSection extends StatefulWidget {
  @override
  _AudioPlaylistSectionState createState() => _AudioPlaylistSectionState();
}

class _AudioPlaylistSectionState extends State<AudioPlaylistSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlaylistSectionViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => locator<AudioPlaylistSectionViewModel>(),
        // onModelReady: (model) => model.getPlaylist(),
        builder: (context, model, _) {
          return model.isBusy
              ? Center(child: CircularProgressIndicator())
              : model.playList == null
                  ? Retry(
                      onRetry: model.getPlaylist,
                    )
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
                        model.playList.isEmpty
                            ? Empty(
                                title: "You are yet to create a playlist",
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: model.getPlaylist,
                                  child: GridView.count(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 156 / 112,
                                    shrinkWrap: true,
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width > 550
                                            ? 3
                                            : 2,
                                    children: List.generate(
                                      model.playList.length,
                                      (index) => PlayListWidget(
                                        model.playList[index],
                                        onDelete: () => model.onDelete(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    );
        });
  }

  showBottomSheet(
      BuildContext context, AudioPlaylistSectionViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (context) => Container(
        // width: double.infinity,

        ///this allows bottom sheet to display above the keyboard
        height: MediaQuery.of(context).size.height / 2 +
            MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.all(20.0),
        child: ViewModelBuilder<AudioPlaylistSectionViewModel>.reactive(
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
