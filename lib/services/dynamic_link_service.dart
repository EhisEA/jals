import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:jals/models/content_model.dart';
import 'package:jals/services/authentication_service.dart';
import 'package:jals/utils/locator.dart';
import '../route_paths.dart';
import 'navigationService.dart';

class DynamicLinkService {
  final NavigationService _navigationService = locator<NavigationService>();

  //STARTUP FROM DYNAMIC LINK LOGIC

  //Get initial dynamic lin if the app is started usign the link
  Future handleDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);

    //INTO FOREGROUND FROM DYNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLinData) async {
        _handleDeepLink(dynamicLinData);
      },
      onError: (OnLinkErrorException e) async {
        debugPrint("dynamic link failed: ${e.message}");
      },
    );
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      debugPrint("_handleDeepLink | deepLink: $deepLink");

      AuthenticationService _authenticationService =
          locator<AuthenticationService>();
      // don't attempt to get post if user is not logged in
      if (_authenticationService.currentUser == null) return;
      //check if link contains contentid and contentType
      var isPost = deepLink.queryParameters['contentId'] != null &&
          deepLink.queryParameters['contentType'] != null;

      print(deepLink.pathSegments.contains('contentType'));
      print(deepLink.pathSegments.contains('contentId'));
      print(deepLink.queryParameters['contentId']);
      print(deepLink.queryParameters['contentType']);
      if (isPost) {
        var contentId = deepLink.queryParameters['contentId'];
        var contentType = deepLink.queryParameters['contentType'];

        if (contentId != null && contentType != null) {
          _navigationService.navigateTo(
            DynamicLinkEntryViewRoute,
            argument: {
              "contentId": contentId,
              "contentType": contentType,
            },
          );
        }
      }
    }
  }

  Future<String> createEventLink(ContentModel content) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://jals.page.link/',
      link: Uri.parse(
          'https://jals.page.link/Post/?contentId=${content.id}&contentType=${content.getContentTypeString(content.postType)}'),
      androidParameters: AndroidParameters(
        packageName: 'com.jal.jal',
      ),
      // navigationInfoParameters: NavigationInfoParameters(),
      //ios details will be entered here.
      // iosParameters: IosParameters(
      //   bundleId: 'com.ravenlivestream.raven',
      //   minimumVersion: '1.0.0',
      //   appStoreId: '1541951758',
      // ),
      // googleAnalyticsParameters: GoogleAnalyticsParameters(
      //   campaign: 'eventLinks',
      //   medium: 'social',
      //   source: 'orkut',
      // ),
      // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      //   providerToken: '00000',
      //   campaignToken: 'example-promo',
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: content.title,
        // description: event.description,
        imageUrl: Uri.parse(content.coverImage),
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri dynamicUrl = shortDynamicLink.shortUrl;

    return dynamicUrl.toString();
  }
}
