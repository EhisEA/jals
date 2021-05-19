import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jals/enums/content_type.dart';
import 'package:jals/ui/search_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/audio_tile.dart';
import 'package:jals/widgets/back_icon.dart';
import 'package:jals/widgets/video_tile.dart';
import 'package:stacked/stacked.dart';

import 'authentication/components/auth_textfield.dart';

class SearchView extends StatelessWidget {
  final ContentType contentType;

  const SearchView(this.contentType);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(contentType),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            leading: BackIcon(),
            title: TextHeader(text: "Search"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SearchTextField(
                          controller: model.searchController,
                          hintText: "Search for ...",
                          prefixIcon: CupertinoIcons.search,
                          keyboardType: TextInputType.text,
                          // fieldColor: kPrimaryColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: model.search,
                          child: TextHeader3(
                            text: "Search",
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: model.isBusy
                      ? Center(child: CircularProgressIndicator())
                      : showList(model),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showList(SearchViewModel model) {
    switch (contentType) {
      case ContentType.Audio:
        return ListView.builder(
          itemCount: model.audioList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
              child: AudioTile(
                audio: model.audioList[index],
                popOption: ["Share"],
                onOptionSelect: (value) => model.onOptionSelect(
                  value,
                  model.audioList[index],
                ),
              ),
            );
          },
        );
        break;
      case ContentType.Video:
        return ListView.builder(
          itemCount: model.videoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
              child: VideoTile(
                videoModel: model.videoList[index],
                popOption: ["Share"],
                onOptionSelect: (value) => model.onOptionSelect(
                  value,
                  model.audioList[index],
                ),
              ),
            );
          },
        );
        break;
      case ContentType.Article:
        return ListView.builder(
          itemCount: model.articleList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
              child: ArticleTile(
                article: model.articleList[index],
              ),
            );
          },
        );
        break;
      default:
    }
  }
}
