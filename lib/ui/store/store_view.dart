import 'package:flutter/material.dart';
import 'package:jals/ui/store/components/build_category_row.dart';
import 'package:jals/ui/store/components/coin_balance.dart';
import 'package:jals/ui/store/purchased_items_view.dart';
import 'package:jals/ui/store/timeline_items_view.dart';
import 'package:jals/ui/store/view_models/build_category_row_view_model.dart';
import 'package:jals/ui/store/view_models/store_view_model.dart';

import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:stacked/stacked.dart';

import 'newest_items_view.dart';

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final PageController _pageController = PageController();
  final BuildCategoryRowViewModel _buildCategoryRowViewModel =
      BuildCategoryRowViewModel();
  @override
  void initState() {
    // _pageController.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<StoreViewModel>.reactive(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all((10)),
                  child: CoinBalance(),
                ),
              ],
              title: TextHeader(
                text: "Store",
              ),
            ),
            body: Column(
              children: [
                BuildCategoryRow(
                  buildCategoryRowViewModel: _buildCategoryRowViewModel,
                  index: model.selectedIndex,
                  onChanged: (index) => _pageController.jumpToPage(index),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _buildCategoryRowViewModel.changeIndex(index);
                      model.changeIndex(index);
                    },
                    children: [
                      NewestItemsView(),
                      TimeLineItemsView(),
                      PurchasedItemsView()
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => StoreViewModel(),
    );
  }
}
