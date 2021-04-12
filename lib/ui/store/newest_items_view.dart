import 'package:flutter/material.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/widgets/article_tile.dart';

class NewestItemsView extends StatelessWidget {
  final List<ContentModel> content;

  const NewestItemsView({Key key, @required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: content == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            )
          : ListView.builder(
              itemCount: content.length,
              itemBuilder: (context, index) => StoreTile(
                content: content[index],
              ),
            ),
    );
  }
}
