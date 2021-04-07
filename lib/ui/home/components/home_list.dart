import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/ui/home/components/view_models/home_content_display_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/image_loader.dart';
import 'package:stacked/stacked.dart';

class HomeContentDisplay extends StatelessWidget {
  final String listTitle;
  final String svgimage;

  const HomeContentDisplay({
    Key key,
    @required this.listTitle,
    @required this.svgimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeContentDisplayViewModel>.reactive(
      viewModelBuilder: () => HomeContentDisplayViewModel(),
      onModelReady: (model) => model.getContents(),
      builder: (context, model, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "$svgimage",
                    height: getProportionatefontSize(20),
                  ),
                  Text(
                    "$listTitle",
                    style: TextStyle(
                      fontSize: getProportionatefontSize(22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "VIEW ALL ",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionatefontSize(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ">",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              // width: 300,
              //getProportionatefontSize(230),
              
              child: model.isBusy
                  ? 
                  Center(child: CircularProgressIndicator())
                  // loadingContent()
                  : model.contents == null
                      ? Center(
                          child: InkWell(
                            onTap: model.getContents,
                            child: TextCaption2(
                                text: "Retry", fontSize: 16, color: kTextColor),
                          ),
                        )
                      : showContent( model),
            )
          ],
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

  showContent( HomeContentDisplayViewModel model) {
    List<ContentModel> contents= model.contents;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: contents.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: ()=>model.openContent(index),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: getProportionatefontSize(150),
                  width: getProportionatefontSize(150),
                  child: ShowNetworkImage(
                    imageUrl: "${contents[index].coverImage}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    "${contents[index].title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: getProportionatefontSize(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  DateFormat("dd MMM yyyy").format(contents[index].createdAt),
                  // "22nd Dec 2021",
                  style: TextStyle(
                    fontSize: getProportionatefontSize(12),
                    fontWeight: FontWeight.w400,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
