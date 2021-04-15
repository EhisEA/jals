import 'package:flutter/material.dart';
import 'package:jals/ui/store/view_models/newest_items_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class NewestItemsView extends StatefulWidget {
  // List<ContentModel> content = [];

  // NewestItemsView({Key key, @required this.content}) : super(key: key);
  @override
  _NewestItemsViewState createState() => _NewestItemsViewState();
}

class _NewestItemsViewState extends State<NewestItemsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<NewestItemsViewModel>.reactive(
      onModelReady: (model) {
        model.getNewestItems();
      },
      builder: (context, model, child) {
        return model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.newestItemList == null
                ? Retry(
                    onRetry: model.getNewestItems,
                  )
                : model.newestItemList.isEmpty
                    ? Empty(
                        title: "No Items",
                      )
                    : ListView.builder(
                        itemCount: model.newestItemList.length,
                        itemBuilder: (context, index) => StoreTile(
                          content: model.newestItemList[index],
                        ),
                      );
      },
      viewModelBuilder: () => NewestItemsViewModel(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
