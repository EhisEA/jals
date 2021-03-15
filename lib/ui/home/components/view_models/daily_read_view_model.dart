import 'package:jals/models/daily_scripture.dart';
import 'package:jals/utils/base_view_model.dart';

class DailyReadViewModel extends BaseViewModel {
  DailyScriptureModel dailyScripture = DailyScriptureModel(
    location: "JOHN CHAPTER 3 VERSES 16-18 NIV",
    scriptureDate: DateTime.now(),
    content: "16 For God so loved the world that he gave his one"
        " and only Son, that whoever believes in him shall not perish "
        "but have eternal life. \n 17 For God did not send his Son into"
        "the world to condemn the world, but to save the world through"
        " him. \n 18 Whoever believes in him is not condemned, but whoever"
        " does not believe stands condemned already because they have"
        " not believed in the name of God’s one and only Son.",
  );

  getdailyScripture() {}
}
