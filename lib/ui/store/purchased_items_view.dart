import 'package:flutter/material.dart';
import 'package:jals/ui/store/view_models/newest_items_view_model.dart';
import 'package:jals/ui/store/view_models/purchased_view_model.dart';
import 'package:jals/widgets/article_tile.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class PurchasedItemsView extends StatefulWidget {
  @override
  _PurchasedItemsViewState createState() => _PurchasedItemsViewState();
}

class _PurchasedItemsViewState extends State<PurchasedItemsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<PurchasedItemsViewModel>.reactive(
      onModelReady: (model) {
        model.getNewestItems();
      },
      builder: (context, model, child) {
        return model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : model.purchaseItemList == null
                ? Retry(
                    onRetry: model.getNewestItems,
                  )
                : model.purchaseItemList.isEmpty
                    ? Empty(
                        title: "No Items",
                      )
                    : ListView.builder(
                        itemCount: model.purchaseItemList.length,
                        itemBuilder: (context, index) => StoreTile(
                          content: model.purchaseItemList[index],
                        ),
                      );
      },
      viewModelBuilder: () => PurchasedItemsViewModel(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
