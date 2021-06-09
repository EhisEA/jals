import 'package:flutter/material.dart';
import 'package:jals/models/date_range_model.dart';
import 'package:jals/ui/store/view_models/newest_items_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/date_utilis.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:jals/widgets/empty.dart';
import 'package:jals/widgets/retry.dart';
import 'package:jals/widgets/store_tile.dart';
import 'package:stacked/stacked.dart';

class TimeLineItemsView extends StatefulWidget {
  @override
  _TimeLineItemsViewState createState() => _TimeLineItemsViewState();
}

class _TimeLineItemsViewState extends State<TimeLineItemsView>
    with AutomaticKeepAliveClientMixin {
  DateRangeModel selected = DateRangeModel(range: "select");
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<StoreTimelineItemsViewModel>.reactive(
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
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                TextHeader2(text: "Explore Timelines"),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => selectRange(
                                      context, model.changeTimeline),
                                  child: Text(
                                    selected.range,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: kPrimaryColor,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Empty(
                              title: "No Items",
                            ),
                          ),
                        ],
                      )
                    : RefreshIndicator(
                        onRefresh: model.getNewestItems,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  TextHeader2(text: "Explore Timelines"),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () => selectRange(
                                        context, model.changeTimeline),
                                    child: Text(
                                      selected == null
                                          ? "Select"
                                          : selected.range,
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: kPrimaryColor,
                                  )
                                ],
                              ),
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
      viewModelBuilder: () => locator<StoreTimelineItemsViewModel>(),
    );
  }

  selectRange(context, Function action) {
    // DateTime a = DateTime.now();
    // var b = DateTime.utc(2007, 06, 27);

    // var years = a.difference(b);
    // print(years.inDays ~/ 365);

    List<DateRangeModel> years =
        DateUtils().getRecentYears(startYear: 2007, range: 3);
    List<DateRangeModel> months = DateUtils().getRecentMonths(range: 3);
    return showDialog(
      // useSafeArea: true,
      context: context,
      builder: (context) => buildCard2(
        children: [
          SizedBox(height: 10),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextHeader2(
                text: "Sort By",
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.close,
                  color: Colors.transparent,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 30),
          ...List.generate((months.length), (index) {
            return buildDate(months[index], context,
                selected: selected.range == months[index].range,
                onSelected: (th, tl) {
              action(th, tl);
            });
          }),
          ...List.generate((years.length), (index) {
            return buildDate(years[index], context,
                selected: selected.range == years[index].range,
                onSelected: (th, tl) {
              action(th, tl);
            });
          })
        ],
      ),
    );
  }

  buildCard2({String title, IconData icon, List<Widget> children}) {
    return Container(
      width: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(children: children).pLTRB(30, 10, 30, 25),
        ),
      ).p12(),
    );
  }

  dol() {
    return showDialog(
      // useSafeArea: true,
      context: context,
      barrierDismissible: true,
      useSafeArea: true,

      builder: (context) => Material(
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return;
          },
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildDate(
    DateRangeModel range,
    BuildContext context, {
    bool selected: false,
    Function(DateTime, DateTime) onSelected,
  }) {
    return GestureDetector(
      onTap: () {
        this.selected = range;
        onSelected(range.th, range.tl);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              JalsIcons.date,
              size: 28,
              color: selected ? kPrimaryColor : Colors.grey,
            ),
            SizedBox(width: 25),
            TextCaption2(
              text: "${range.range}",
              fontSize: 16,
              color: selected ? kPrimaryColor : Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
