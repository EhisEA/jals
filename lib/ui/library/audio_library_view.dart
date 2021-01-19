import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/article_tile.dart';

class AudioLibrary extends StatefulWidget {
  @override
  _AudioLibraryState createState() => _AudioLibraryState();
}

class _AudioLibraryState extends State<AudioLibrary>
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
          title: TextHeader(text: "Audio Library"),
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
                    TextTitle(text: "Playlist"),
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
                      AudioAll(),
                      AudioPlaylist(),
                      AudioDownload(),
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

class AudioAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AudioTile(
            image:
                "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
            title: "How to Pray and Communicate with God",
            author: "Lecrae - Restoration",
          ),
        ),
      ),
    );
  }
}

class AudioDownload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        20,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AudioTile(
            image:
                "https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png",
            title: "How to Pray and Communicate with God",
            author: "Lecrae - Download 2020/30/03",
          ),
        ),
      ),
    );
  }
}

class AudioPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
