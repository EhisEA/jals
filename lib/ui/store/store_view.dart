import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/shop/components/store_card.dart';
import 'package:jals/ui/store/components/build_category_row.dart';
import 'package:jals/ui/store/newest_items_view.dart';
import 'package:jals/ui/store/purchased_items_view.dart';
import 'package:jals/ui/store/timeline_items_view.dart';
import 'package:jals/ui/store/view_models/store_view_model.dart';

import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/text.dart';
import 'package:stacked/stacked.dart';

class StoreView extends StatefulWidget {
  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<StoreViewModel>.reactive(
      onModelReady: (model) {
        model.getNewestItems();
      },
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
                  child: builRoundButton(),
                ),
              ],
              title: TextHeader(
                text: "Store",
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 20),
                BuildCategoryRow(),

                // NewestItemsView(),
                navigateThrough(model.selectedIndex, model),
                // Expanded(
                //   child: model.state == ViewState.Busy
                //       ? SingleChildScrollView(
                //           child: Column(
                //             children: List.generate(15, (index) => StoreCard()),
                //           ),
                //         )
                //       : Center(
                //           child: CircularProgressIndicator(),
                //         ),
                // )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => StoreViewModel(),
    );
  }

  Widget navigateThrough(int index, StoreViewModel model) {
    switch (index) {
      case 0:
        return NewestItemsView(content: model.newestItemList);
      case 1:
        return TimeLineItemsView();

      case 2:
        return PurchasedItemsView();
        break;

      default:
        return NewestItemsView(content: model.newestItemList);
    }
  }

  Widget builRoundButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        // vertical: getProportionatefontSize(5),
        horizontal: getProportionatefontSize(20),
      ),
      decoration: BoxDecoration(
        color: Color(0xffFCF7E4),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "10,000",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12.7),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: Color(0xffC16029),
            ),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.add_circle_outline,
            color: Color(0xffC16029),
          )
        ],
      ),
    );
  }
}
