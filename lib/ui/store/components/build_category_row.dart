import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/store/components/build_bottom_row.dart';
import 'package:jals/ui/store/view_models/build_category_row_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:stacked/stacked.dart';

class BuildCategoryRow extends StatelessWidget {
  final int index;
  final Function(int) onChanged;
  final BuildCategoryRowViewModel buildCategoryRowViewModel;
  const BuildCategoryRow(
      {Key key,
      this.index,
      this.onChanged,
      @required this.buildCategoryRowViewModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<BuildCategoryRowViewModel>.reactive(
        builder: (context, model, child) {
          return Column(
            children: [
              Container(
                height: getProportionatefontSize(50),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    model.items.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: getProportionatefontSize(37),
                      width: getProportionatefontSize(112),
                      decoration: BoxDecoration(
                          // color: Color(0xff),
                          ),
                      child: GestureDetector(
                        onTap: () {
                          model.changeIndex(index);
                          onChanged(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            height: getProportionatefontSize(37),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: model.selectedIndex != index
                                    ? Colors.white
                                    : Color(0xff3C8AF0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                )),
                            child: Text(
                              " ${model.items[index]} ",
                              style: GoogleFonts.sourceSansPro(
                                fontSize: getProportionatefontSize(16),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: model.selectedIndex != index
                                    ? kTextColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // BuildBottomRow(
              //   index: model.selectedIndex,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          );
        },
        viewModelBuilder: () => buildCategoryRowViewModel);
  }
}
