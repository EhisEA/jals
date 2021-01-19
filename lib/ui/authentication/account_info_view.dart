import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/authentication/components/custom_textfield.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/custom_button.dart';

class AccountInfoView extends StatefulWidget {
  @override
  _AccountInfoViewState createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: UIHelper.kSidePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Skip",
                        style: GoogleFonts.sourceSansPro(
                          fontSize: getProportionatefontSize(16),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff01CC97),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Row(
                  children: [
                    Text(
                      "Account info",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getProportionatefontSize(30),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff1F2230),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                buildBox(),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                CustomTextField(
                  controller: nameController,
                  fieldColor: Colors.white,
                  keyboardType: TextInputType.multiline,
                  hintText: "Usifo Murphy",
                  onSaved: (String value) {},
                  prefixIcon: Image.asset("icons/contact.png"),
                  suffixIcon: Container(height: 3, width: 3),
                  title: "Full Name",
                  validator: (String v) => v.isEmpty ? "" : null,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  keyboardType: TextInputType.multiline,
                  controller: phoneNumberController,
                  hintText: "+171615020202",
                  fieldColor: Colors.white,
                  onSaved: (String value) {},
                  prefixIcon: Image.asset("icons/phone.png"),
                  suffixIcon: Container(height: 3, width: 3),
                  title: "Phone Number",
                  validator: (String v) => v.isEmpty ? "" : null,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomTextField(
                  keyboardType: TextInputType.multiline,
                  controller: dateController,
                  hintText: "31/07/1986",
                  fieldColor: Colors.white,
                  onSaved: (String value) {},
                  prefixIcon: Image.asset("icons/calender.png"),
                  suffixIcon: Container(height: 3, width: 3),
                  title: "Date of Birth",
                  validator: (String v) => v.isEmpty ? "" : null,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                CustomButton(
                  color: Color(0xff3C8AF0),
                  onPressed: () {},
                  title: "Explore JALS",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBox() {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xff191A32),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Image.asset("icons/Profile.png"),
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: buildCircle(),
          )
        ],
      ),
    );
  }

  Widget buildCircle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      // height: getProportionateScreenHeight(34),
      // width: getProportionateScreenWidth(34),
      decoration: BoxDecoration(
        color: Color(0xff767780),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.camera_alt,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}
