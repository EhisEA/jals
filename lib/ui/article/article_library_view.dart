import 'package:flutter/material.dart';
import 'package:jals/ui/article/components/article_all.dart';
import 'package:jals/ui/article/components/article_bookmark.dart';
import 'package:jals/ui/article/components/article_download.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';

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
