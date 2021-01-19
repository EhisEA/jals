import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/image.dart';

class ArticleLibrary extends StatefulWidget {
  @override
  _ArticleLibraryState createState() => _ArticleLibraryState();
}

class _ArticleLibraryState extends State<ArticleLibrary>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          title: TextHeader(text: "Article Library"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: getProportionatefontSize(30),
                child: TabBar(
                  labelColor: Colors.black,
                  controller: _controller,
                  // indicatorWeight: 4,
                  // indicatorPadding: EdgeInsets.all(0),
                  labelPadding: EdgeInsets.all(0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: kPrimaryColor,
                  // indicatorPadding: ,
                  tabs: [
                    TextTitle(text: "All"),
                    TextTitle(text: "Bookmark"),
                    TextTitle(text: "Download"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      ArticleAll(),
                      ArticleBookmark(),
                      ArticleDownload(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 336 / 160,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
          text: "How to read, understand and decipher the teachings of Christ",
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              category(title: "Article", selected: true),
              category(title: "News", selected: false),
              category(title: "Trending", selected: false),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height - 300,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
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
            ))
      ],
    );
  }

  category({
    @required String title,
    bool selected = false,
  }) {
    return Expanded(
      child: Container(
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
    );
  }
}

class ArticleBookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ArticleTile(
            image:
                "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg",
            title:
                "How to read, understand and decipher the teachings of Christ",
            author: "Esther Howard",
            isBookmark: true,
          ),
        ),
      ),
    );
  }
}

class ArticleDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ArticleTile(
            image:
                "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
            title:
                "How to read, understand and decipher the teachings of Christ",
            author: "Esther Howard .  Download 2020/30/03",
          ),
        ),
      ),
    );
  }
}
