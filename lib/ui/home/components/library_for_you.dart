import 'package:flutter/material.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/ui/home/components/view_models/home_content_display_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/image_loader.dart';
import 'package:stacked/stacked.dart';

class LibraryForYou extends StatelessWidget {
  const LibraryForYou({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeContentDisplayViewModel>.reactive(
      viewModelBuilder: () => HomeContentDisplayViewModel(),
      onModelReady: (model) => model.getContents(),
      builder: (context, model, _) {
        return Container(
          child: model.isBusy
              ? Center(child: CircularProgressIndicator())
              // loadingContent()
              : model.contents == null
                  ? Center(
                      child: InkWell(
                        onTap: model.getContents,
                        child: TextCaption2(
                            text: "Retry", fontSize: 16, color: kTextColor),
                      ),
                    )
                  : showContent(model),
        );
      },
    );
  }

  loadingContent() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionatefontSize(150),
                width: getProportionatefontSize(150),
                child: ImageShimmerLoadingState(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  child: ImageShimmerLoadingState(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 10,
                width: 150,
                child: ImageShimmerLoadingState(),
              ),
            ],
          ),
        );
      },
    );
  }

  showContent(HomeContentDisplayViewModel model) {
    List<ContentModel> contents = model.contents;
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return LibraryForYouTile(content: contents[index]);
          },
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
