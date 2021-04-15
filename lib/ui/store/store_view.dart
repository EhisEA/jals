import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/store/components/build_category_row.dart';
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
      onModelReady: (model) {
        // model.getNewestItems();
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

            //  Column(
            //   children: [
            //     SizedBox(height: 20),
            //     BuildCategoryRow(),
            //     // NewestItemsView(),
            //     navigateThroughTabs(model.selectedIndex, model),
            //   ],
            // ),
          ),
        );
      },
      viewModelBuilder: () => StoreViewModel(),
    );
  }

  Widget navigateThroughTabs(int index, StoreViewModel model) {
    if (index == 0) {
      print("The Index is ============$index");
      return CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    } else if (index == 1) {
      print("The Index is ============$index");
      return CircularProgressIndicator(
        backgroundColor: Colors.blue,
      );
    } else if (index == 2) {
      print("The Index is ============$index");
      return CircularProgressIndicator(
        backgroundColor: Colors.orange,
      );
    } else {
      print("The Index is ============$index");
      return CircularProgressIndicator(
        backgroundColor: Colors.pink,
      );
    }
    // switch (index) {
    //   case 0:
    //     return CircularProgressIndicator(
    //       backgroundColor: Colors.red,
    //     );
    //   case 1:
    //     return CircularProgressIndicator(
    //       backgroundColor: Colors.blue,
    //     );

    //   case 2:
    //     return PurchasedItemsView();
    //     break;

    //   default:
    //     return CircularProgressIndicator(
    //       backgroundColor: Colors.red,
    //     );
    // }
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
