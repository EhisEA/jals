import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

class AudioPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                showBottomSheet(context);
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
              20,
              (index) => Container(
                color: kPrimaryColor,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        TextCaptionWhite(
                          text: "Motivation",
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
                      text: "12 Songs",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: TextHeader(text: "Customize your playlist")),
              SizedBox(height: 20),
              TextCaption(text: "Enter Name Of Playlist"),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
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
              Center(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
