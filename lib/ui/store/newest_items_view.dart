import 'package:flutter/material.dart';
import 'package:jals/ui/store/view_models/newest_items_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:jals/widgets/store_tile.dart';
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
      disposeViewModel: false,
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
                    : RefreshIndicator(
                        onRefresh: model.getNewestItems,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: TextHeader2(text: "Newest Collections"),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: model.newestItemList.length,
                                itemBuilder: (context, index) => StoreTile(
                                  content: model.newestItemList[index],
                                  callback: () =>
                                      model.addItemToPurchased(index),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
      },
      viewModelBuilder: () => locator<NewestItemsViewModel>(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
