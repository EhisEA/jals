import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';

class VideoLibrary extends StatefulWidget {
  @override
  _VideoLibraryState createState() => _VideoLibraryState();
}

class _VideoLibraryState extends State<VideoLibrary>
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
          title: TextHeader(text: "Video Library"),
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
                    TextTitle(text: "Watch Later"),
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
                      VideoAll(),
                      VideoWatchLater(),
                      VideoDownload(),
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

class VideoAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: VideoTile(
            image:
                "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
            title: "How to Pray and Communicate with God",
            author: "Wade Warren",
          ),
        ),
      ),
    );
  }
}

class VideoWatchLater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: VideoTile(
            image:
                "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
            title: "How to Pray and Communicate with God",
            author: "Wade Warren",
            showPrimaryButton: false,
          ),
        ),
      ),
    );
  }
}

class VideoDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: VideoTile(
            image:
                "https://cdn.mos.cms.futurecdn.net/yL3oYd7H2FHDDXRXwjmbMf.jpg",
            title: "How to Pray and Communicate with God",
            author: "Download 2020/30/03",
            showPrimaryButton: false,
            showSecondaryButton: false,
          ),
        ),
      ),
    );
  }
}
