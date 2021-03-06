import 'package:flutter/material.dart';
import 'package:jals/ui/store/view_models/purchased_view_model.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:jals/widgets/store_tile.dart';
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
      disposeViewModel: false,
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
                    : RefreshIndicator(
                        onRefresh: model.getNewestItems,
                        child: ListView.builder(
                          itemCount: model.purchaseItemList.length,
                          itemBuilder: (context, index) => StoreTilePurchased(
                            content: model.purchaseItemList[index],
                            // callback: () => model.getNewestItems(),
                          ),
                        ),
                      );
      },
      viewModelBuilder: () => locator<PurchasedItemsViewModel>(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
