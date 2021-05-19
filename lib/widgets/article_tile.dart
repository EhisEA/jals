import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/models/article_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image.dart';

class ArticleTile extends StatelessWidget {
  final ArticleModel article;

  const ArticleTile({
    Key key,
    @required this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: InkWell(
        onTap: () {
          NavigationService _navigationService = locator<NavigationService>();
          _navigationService.navigateTo(ArticleViewRoute, argument: article);
        },
        child: Row(
          children: [
            Container(
              height: getProportionatefontSize(80),
              width: getProportionatefontSize(80),
              child: AspectRatio(
                aspectRatio: 1,
                child: ShowNetworkImage(imageUrl: article.coverImage),
              ),
            ),
            Expanded(
              child: ListTile(
                title: TextTitle(
                  text: "${article.title}",
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 5),
                        child: TextCaption(
                          text: article.downloadDate != null
                              ? "Downloaded ${DateFormat("dd/MM/yyyy").format(article.downloadDate)}"
                              : "${article.author}",
                        ),
                      ),
                    ),
                    article.isBookmarked == null || article.downloaded
                        ? SizedBox()
                        : article.isBookmarked
                            ? Icon(
                                Icons.bookmark,
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
