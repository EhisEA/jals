import 'package:flutter/material.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/ui/audio/view_model/audio_playlist_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:stacked/stacked.dart';

import '../../../route_paths.dart';

class AudioPlaylist extends StatefulWidget {
  @override
  _AudioPlaylistState createState() => _AudioPlaylistState();
}

class _AudioPlaylistState extends State<AudioPlaylist> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AudioPlaylsitViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: ()=>AudioPlaylsitViewModel(),
      onModelReady: (model)=>model.getPlaylist(),
      builder: (context, model,_) {
        return model.isBusy
              ? Center(child: CircularProgressIndicator())
              : model.playList == null
                  ? Center(
                      child: IconButton(
                          icon: Icon(Icons.refresh), onPressed: model.getPlaylist))
                  : Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showBottomSheet(context,model);
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
                crossAxisCount: MediaQuery.of(context).size.width > 550 ? 3 : 2,
                children: List.generate(
                  model.playList.length,
                  (index) =>PlayListWidget(model.playList[index])
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  showBottomSheet(BuildContext context, AudioPlaylsitViewModel model) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: 
        
        model.isSecondaryBusy?
        Center(child:CircularProgressIndicator()):
        SingleChildScrollView(
          child: Form(
            key: model.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: TextHeader(text: "Customize your playlist")),
                SizedBox(height: 20),
                TextCaption(text: "Enter Name Of Playlist"),
                SizedBox(height: 10),
                TextFormField(
                  controller: model.playlistNameController,
                  validator: (value){
                    if(value.isEmpty){
                      return "You must enter a playlist name";
                    }
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
                SizedBox(height: 30),
                TextCaption(text: "Choose Mood Color"),
                SizedBox(height: 10),
                GridView.extent(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  maxCrossAxisExtent: 40,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                  ],
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: (){
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
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class PlayListWidget extends StatelessWidget {
  final PlayListModel playList;
  final _navigationSrevice=locator<NavigationService>();
   PlayListWidget(this.playList,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        _navigationSrevice.navigateTo(AudioPlaylistViewRoute, argument: playList);
      },
      child: Container(
                      color: kPrimaryColor,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              TextCaptionWhite(
                                text: playList.title,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
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