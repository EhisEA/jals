import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/date_range_model.dart';

class DateUtils {
  ///
  /// this ia a fuction that return a list of years
  /// ranging from start year up until recent year
  /// and group them according to the range
  /// ```
  ///  List<DateRangeModel> years =
  ///      DateUtils().getRecentYears(startYear: 2009, range: 3);
  /// ```
  /// this would return
  /// [2009-2011] [2012-2014] [2015-2017] [2018-2020]
  /// [2021-2021]
  /// assuming we are in 2021
  List<DateRangeModel> getRecentYears({
    /// this indicate the year to start from
    @required int startYear,

    /// this indicate how many years should be grouped
    /// together
    int range,
  }) {
    int loop = 0;
    int year = 0;
    int yea =
        (DateTime.now().toUtc().difference(DateTime(startYear, 1, 1).toUtc()))
            .inDays;
    for (var i = 0; yea > 365; i++) {
      year++;
      yea -= 365;
    }
    print(year);
    List<DateRangeModel> years = [];

    for (var i = 1; i <= year; i++) {
      if ((i % range) == 0 && i != 0 || i == year) {
        if (loop == 0) {
          years.add(
            DateRangeModel(
              tl: DateTime(startYear, 1, 1),
              th: DateTime((startYear + i), 12, 31),
              range: "$startYear-${startYear + i}",
            ),
          );
        } else {
          if (i == year && (year % range) != 0) {
            //if the start and the end years are the same range should
            //be just one year
            String rangeVal;
            if ((startYear + (((i - (year % range) + 1)))) == startYear + i) {
              rangeVal = "${startYear + i}";
            } else {
              print((year % range));
              print((((i - (year % range) + 1))));
              rangeVal =
                  "${startYear + (((i - (year % range) + 1)))}-${startYear + i}";
            }
            years.add(
              DateRangeModel(
                tl: DateTime(startYear + ((i - (year % range) + 1)), 1, 1),
                th: DateTime((startYear + i), 12, 31),
                range: rangeVal,
              ),
            );
          } else
            years.add(
              DateRangeModel(
                tl: DateTime(startYear + (i - (range - 1)), 1, 1),
                th: DateTime((startYear + i), 12, 31),
                range: "${startYear + (i - (range - 1))}-${startYear + i}",
              ),
            );
        }
        loop++;
      }
    }
    years = years.reversed.toList();
    return years;
  }

  List<DateRangeModel> getRecentMonths({@required int range}) {
    List<DateRangeModel> months = [];
    int month = DateTime.now().month;
    int loop = 0;

    for (var i = 1; i <= month; i++) {
      if ((i % range) == 0 && i != 0 || i == month) {
        loop++;

        switch (loop) {
          case 1:
            String rangeVal;
            if ("january" ==
                "${DateFormat.MMMM().format(DateTime(2021, i))}"
                    .toLowerCase()) {
              rangeVal = "January";
            } else {
              rangeVal =
                  "January-${DateFormat.MMMM().format(DateTime(2021, i))} ";
            }
            months.add(
              DateRangeModel(
                th: DateTime(2021, i, 31),
                tl: DateTime(2021, 1, 1),
                range: rangeVal,
              ),
            );
            break;
          case 2:
            String rangeVal;
            if ("april" ==
                "${DateFormat.MMMM().format(DateTime(2021, i))}"
                    .toLowerCase()) {
              rangeVal = "April";
            } else {
              rangeVal = "April-${DateFormat.MMMM().format(DateTime(2021, i))}";
            }
            months.add(
              DateRangeModel(
                th: DateTime(2021, i, 31),
                tl: DateTime(2021, 4, 1),
                range: rangeVal,
              ),
            );
            break;
          case 3:
            String rangeVal;
            if ("july" ==
                "${DateFormat.MMMM().format(DateTime(2021, i))}"
                    .toLowerCase()) {
              rangeVal = "July";
            } else {
              rangeVal = "July-${DateFormat.MMMM().format(DateTime(2021, i))}";
            }
            months.add(
              DateRangeModel(
                th: DateTime(2021, i, 31),
                tl: DateTime(2021, 7, 1),
                range: rangeVal,
              ),
            );
            break;
          case 4:
            String rangeVal;
            if ("october" ==
                "${DateFormat.MMMM().format(DateTime(2021, i))}"
                    .toLowerCase()) {
              rangeVal = "October";
            } else {
              rangeVal =
                  "October-${DateFormat.MMMM().format(DateTime(2021, i))}";
            }
            months.add(
              DateRangeModel(
                th: DateTime(2021, i, 31),
                tl: DateTime(2021, 10, 1),
                range: rangeVal,
              ),
            );
            break;
        }
      }
    }
    return months.reversed.toList();
  }
}
