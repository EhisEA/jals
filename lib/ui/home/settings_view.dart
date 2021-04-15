import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jals/ui/home/view_models/settings_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/widgets/image.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: Colors.blue,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SafeArea(
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: getProportionatefontSize(18),
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ).p(30),
                    ),
                    InkWell(
                      onTap: () {
                        if (!model.isSecondaryBusy) {
                          model.showImageSelectionDialog(context);
                        }
                      },
                      child: model.avatar == null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, size: 60),
                            ).p(20)
                          : Container(
                              width: 140,
                              height: 140,
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      child: model.avatar != null
                                          ? ShowNetworkImage(
                                              imageUrl: model.avatar,
                                            )
                                          : Center(
                                              child: Icon(
                                              Icons.person,
                                              color: kPrimaryColor,
                                              size: 50,
                                            )),
                                    ),
                                  ),
                                  // show loader to indicate that image is uploading
                                  model.isSecondaryBusy
                                      ? ClipOval(
                                          child: Container(
                                              width: 140,
                                              height: 140,
                                              color: Colors.black38,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ))),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                    ),
                    Text(
                      model.fullname ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildCard(
                      title: "Account Settings",
                      icon: Icons.person,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            Text(
                              "Account Settings",
                              style: TextStyle(
                                  // fontSize: getProportionatefontSize(18),
                                  fontWeight: FontWeight.w700),
                            ).p(15)
                          ],
                        ),
                        buildUserInfo(
                            "Name",
                            model.fullname,
                            () => model.update(
                                context, UserUpdateType.FULLNAME, model)),
                        buildUserInfo(
                            "Phone Number",
                            model.phone,
                            () => model.update(
                                context, UserUpdateType.PHONE, model)),
                        buildUserInfo(
                            "Birthday",
                            model.dateOfBirth == null
                                ? ""
                                : DateFormat("dd-MMM-yyyy")
                                    .format(model.dateOfBirth),
                            () => model.update(
                                context, UserUpdateType.DATEOFBIRTH, model)),
                        buildUserInfo("email", model.email, null),
                        buildUserInfo(
                            "password",
                            "******",
                            () => model.update(
                                context, UserUpdateType.PASSWORD, model))
                      ],
                    ),
                    buildCard(
                      title: "Notifications ",
                      icon: Icons.person,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.blue,
                            ),
                            Text(
                              "Notification",
                              style: TextStyle(
                                  // fontSize: getProportionatefontSize(18),
                                  fontWeight: FontWeight.w700),
                            ).p(15)
                          ],
                        ),
                        buildNotificationInfo(
                          "Push Notification",
                          "Receive push notification on daily reads and Scriptures JALS.",
                        ),
                        buildNotificationInfo(
                          "Email Notification",
                          "Receive email notification update on daily reads and artices you like.",
                        ),
                        buildNotificationInfo(
                          "SMS Notification",
                          "Receive daily reads in your SMS box.",
                        ),
                      ],
                    ),
                    buildCard(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Submit Feedback",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            ),
                          ],
                        ).py20(),
                        InkWell(
                          onTap: model.logOut,
                          child: Row(
                            children: [
                              // Icon(
                              //   Icons.login,
                              //   color: Colors.blue,
                              // ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Log me out",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                              ),
                            ],
                          ).py20(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildCard({String title, IconData icon, List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: children)
          .pLTRB(30, 10, 30, 25),
    ).pSymmetric(h: 30, v: 20);
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

  buildNotificationInfo(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title",
              style: TextStyle(
                  // fontSize: getProportionatefontSize(18),
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            CupertinoSwitch(
              trackColor: Colors.grey,
              value: false,
              onChanged: (value) {},
            ).scale75()
          ],
        ),
        Text(
          "$subtitle",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ).py16();
  }

  buildUserInfo(String title, String subtitle, Function action) {
    return Row(
      children: [
        Text("$title").py(20),
        SizedBox(width: 20),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              subtitle ?? "......   ",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ],
    ).onTap(action);
  }
}
