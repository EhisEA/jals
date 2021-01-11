import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Settings",
                style: TextStyle(
                    fontSize: getProportionatefontSize(18),
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ).p(30),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
              ).p(20),
              Text(
                "Jacob Jones",
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
                  buildUserInfo("Name", "Jacob Jones"),
                  buildUserInfo("Phone Number", "08129292992"),
                  buildUserInfo("Birthday", "31-july-2020"),
                  buildUserInfo("email", "emmanueleayemere@gmail.com"),
                  buildUserInfo("password", "******")
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
                  Row(
                    children: [
                      Icon(
                        Icons.login,
                        color: Colors.blue,
                      ),
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
                  ).py20()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  r(context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: buildCard2(
          children: [
            Text(
              "Edit Password",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionatefontSize(16)),
            ).p(30),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            VxTextField(
              borderType: VxTextFieldBorderType.roundLine,
              borderRadius: 0,
              isPassword: true,
              borderColor: Colors.grey.shade300,
              clear: false,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            VxTextField(
              borderType: VxTextFieldBorderType.roundLine,
              borderRadius: 0,
              isPassword: true,
              borderColor: Colors.grey.shade300,
              clear: false,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline),
            ),
            SizedBox(height: 30),
            Container(
              child: Center(
                child: Text(
                  "Save Changes",
                ),
              ),
            ).p20().backgroundColor(Colors.grey.shade100),
            // SizedBox(height: 10),
            Text("Cancel").p20()
          ],
        ),
      ),
    );
  }

  r1(context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: buildCard2(
          children: [
            Text(
              "Edit Password",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionatefontSize(16)),
            ).p(30),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            VxTextField(
              borderType: VxTextFieldBorderType.roundLine,
              borderRadius: 0,
              isPassword: true,
              borderColor: Colors.grey.shade300,
              clear: false,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            VxTextField(
              borderType: VxTextFieldBorderType.roundLine,
              borderRadius: 0,
              isPassword: true,
              borderColor: Colors.grey.shade300,
              clear: false,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline),
            ),
            SizedBox(height: 30),
            Container(
              child: Center(
                child: Text(
                  "Save Changes",
                ),
              ),
            ).p20().backgroundColor(Colors.grey.shade100),
            // SizedBox(height: 10),
            Text("Cancel").p20()
          ],
        ),
      ),
    );
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

  buildUserInfo(String title, String subtitle) {
    return Row(
      children: [
        Text("$title").py(20),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$subtitle",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ],
    ).onTap(() => r(context));
  }
}
