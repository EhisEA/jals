import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/image.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ArticleAll extends StatefulWidget {
  @override
  _ArticleAllState createState() => _ArticleAllState();
}

class _ArticleAllState extends State<ArticleAll> {
  int selected = 0;
  changeSelected(int index) {
    selected = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 336 / 160,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.hardEdge,
                  child: ShowNetworkImage(
                    imageUrl:
                        "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/07/Man-Silhouette.jpg",
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextCaption(
                text: "3 day ago",
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
            ],
          ),
        ),
        MultiSliver(
          children: [
            SliverPinnedHeader(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    category(title: "Article", index: 0),
                    category(title: "News", index: 1),
                    category(title: "Trending", index: 2),
                  ],
                ),
              ),
            ),
            SliverClip(
              child: SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    20,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ArticleTile(
                        image:
                            "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
                        title:
                            "How to read, understand and decipher the teachings of Christ",
                        author: "Esther Howard ",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  category({
    @required String title,
    @required int index,
  }) {
    bool selected = this.selected == index;
    return Expanded(
      child: InkWell(
        onTap: () => changeSelected(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: selected ? kPrimaryColor : Colors.white,
            border: Border.all(
              color: selected ? kPrimaryColor : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: TextArticle(
              text: "$title",
              color: selected ? Colors.white : kTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
