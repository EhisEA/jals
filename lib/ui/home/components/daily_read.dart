import 'package:flutter/material.dart';
import 'package:jals/ui/home/components/view_models/daily_read_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/text.dart';
import 'package:jals/widgets/image_loader.dart';
import 'package:stacked/stacked.dart';

class DailyRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DailyReadViewModel>.reactive(
      viewModelBuilder: () => locator<DailyReadViewModel>(),
      onModelReady: (model) => model.getdailyScripture(),
      builder: (context, model, _) {
        return Container(
          margin: EdgeInsets.all(20),
          color: kPrimaryColor,
          padding: EdgeInsets.all(20),
          child: model.dailyScripture == null
              ? Center(
                  child: InkWell(
                    onTap: model.getdailyScripture,
                    child: TextCaptionWhite(
                      text: "Retry",
                      fontSize: 16,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        TextCaptionWhite(
                          text: "DAILY READ",
                          fontSize: 14,
                        ),
                        Spacer(),
                        model.isBusy
                            ? Container(
                                height: 20,
                                width: 100,
                                child: ImageShimmerLoadingState(),
                              )
                            : TextCaptionWhite(
                                text: model.dailyScripture.location != null
                                    ? model.dailyScripture.location
                                    : "" //"John 3:16",
                                ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: model.isBusy
                          ? Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  child: ImageShimmerLoadingState(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  child: ImageShimmerLoadingState(),
                                ),
                              ],
                            )
                          : TextDailyRead(
                              text: model.dailyScripture.content != null
                                  ? model.dailyScripture.content
                                  : "" //"John 3:16",
                              ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
