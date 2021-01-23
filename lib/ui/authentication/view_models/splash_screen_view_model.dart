import 'package:jals/utils/base_view_model.dart';
import 'package:jals/route_paths.dart';
import 'package:jals/services/navigationService.dart';

import '../../../utils/locator.dart';

class SplashScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    _navigationService.navigateToReplace(WelcomeViewRoute);
  }
}
