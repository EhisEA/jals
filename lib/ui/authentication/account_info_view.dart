import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/view_models/account_info_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:stacked/stacked.dart';

class AccountInfoView extends StatefulWidget {
  @override
  _AccountInfoViewState createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AccountInfoViewModel>.reactive(
        // onModelReady: (model) => model.onModelReady,

        viewModelBuilder: () => AccountInfoViewModel(),
        builder: (context, model, _) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: UIHelper.kSidePadding,
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            InkWell(
                              // onTap: model.skip,
                              onTap: model.pickDate(context),
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
                        AuthTextField(
                          controller: model.nameController,
                          fieldColor: Colors.white,
                          keyboardType: TextInputType.multiline,
                          hintText: "Usifo Murphy",
                          prefixIcon: JalsIcons.account_circle,
                          title: "Full Name",
                          validator: (String v) => v.isEmpty ? "" : null,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        AuthTextField(
                          keyboardType: TextInputType.multiline,
                          controller: model.phoneNumberController,
                          hintText: "+171615020202",
                          fieldColor: Colors.white,
                          prefixIcon: Icons.phone,
                          title: "Phone Number",
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        AuthTextField(
                          keyboardType: TextInputType.multiline,
                          controller: model.dateController,
                          hintText: "31/07/1986",
                          fieldColor: Colors.white,
                          prefixIcon: JalsIcons.date,
                          title: "Date of Birth",
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        model.state == ViewState.Busy
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : DefaultButton(
                                color: Color(0xff3C8AF0),
                                onPressed: model.uploadDetails,
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
            ),
          );
        });
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
