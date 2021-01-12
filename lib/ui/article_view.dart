import 'package:flutter/material.dart';
import 'package:jals/constants/dummy_text.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/image_loader.dart';

class ArticleView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_up),
                  Text(
                    "Scroll Up",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(width: 40),
            InkWell(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_down),
                  Text(
                    "Scroll Down",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.bookmark_outline,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.share_outlined,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            AspectRatio(
              aspectRatio: 336 / 160,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.hardEdge,
                child: ShowNetworkImage(
                    imageUrl:
                        "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png"),
              ),
            ),
            SizedBox(height: 20),
            TextCaption(
              text: "23rd December 2020",
            ),
            SizedBox(
              height: 10,
            ),
            TextHeader(
              text:
                  "How to read, understand and decipher the teachings of Christ",
            ),
            SizedBox(
              height: 10,
            ),
            TextCaption(
              text: "By T.D Jake",
            ),
            SizedBox(
              height: 10,
            ),
            TextArticle(
              text: dummyArticle,
            ),
            ArticleTile(
              image:
                  "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
              title:
                  "How to read, understand and decipher the teachings of Christ",
              author: "Esther Howard",
            ),
          ],
        ),
      ),
    );
  }
}
