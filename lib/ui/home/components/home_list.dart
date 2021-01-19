import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';

class HomeList extends StatelessWidget {
  final String listTitle;
  final String svgimage;

  const HomeList({
    Key key,
    @required this.listTitle,
    @required this.svgimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          height: getProportionatefontSize(230),
          child: ListView.builder(
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
                      color: kTextColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        "Declare your Love for God",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: getProportionatefontSize(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "22nd Dec 2021",
                      style: TextStyle(
                        fontSize: getProportionatefontSize(12),
                        fontWeight: FontWeight.w400,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
