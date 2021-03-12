import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/jals_icons_icons.dart';
import 'package:jals/ui/authentication/components/auth_textfield.dart';
import 'package:jals/ui/authentication/view_models/account_info_view_model.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/image.dart';
import 'package:jals/widgets/loader_page.dart';
import 'package:stacked/stacked.dart';

class AccountInfoView extends StatefulWidget {
  @override
  _AccountInfoViewState createState() => _AccountInfoViewState();
}

class _AccountInfoViewState extends State<AccountInfoView> {
  FocusNode _focusDateField = FocusNode();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<AccountInfoViewModel>.reactive(
        viewModelBuilder: () => AccountInfoViewModel(),
        builder: (context, model, _) {
          _focusDateField.unfocus();
          return LoaderPageRipple(
            busy: model.isSecondaryBusy,
            child: SafeArea(
              child: Center(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
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
                                  model.isBusy
                                      ? SizedBox(height: 20)
                                      : InkWell(
                                          // onTap: model.skip,
                                          onTap: () {
                                            model.skip();
                                          },
                                          child: Text(
                                            "Skip",
                                            style: GoogleFonts.sourceSansPro(
                                              fontSize:
                                                  getProportionatefontSize(16),
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
                              buildProfilePicture(model),
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
                              buildDateOfBirthField(
                                context,
                                callBack: () {
                                  model.pickDate(context).then((v) {
                                    model.dateController.text = model
                                                .pickedDate ==
                                            null
                                        ? ""
                                        : "${DateFormat('dd/MM/yyyy').format(model.pickedDate)}";
                                    //remove focus from date textfield
                                    _focusDateField.unfocus();
                                  });
                                },
                                controller: model.dateController,
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
                ),
              ),
            ),
          );
        });
  }

  Widget buildProfilePicture(AccountInfoViewModel model) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          model.currentAvatar == null && model.image == null
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff191A32),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Image.asset("icons/Profile.png"),
                )
              : SizedBox(),
          model.currentAvatar == null
              ? SizedBox()
              : Container(
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: ShowNetworkImage(
                    imageUrl: model.currentAvatar,
                  ),
                ),
          model.image != null
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(model.image), fit: BoxFit.cover),
                    color: Color(0xff191A32),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: -5,
            right: -5,
            child: InkWell(
              onTap: () => model.showImageSelectionDialog(context),
              child: buildCircle(),
            ),
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

  Widget buildDateOfBirthField(BuildContext context,
      {@required VoidCallback callBack,
      @required TextEditingController controller}) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date of Birth",
            style: TextStyle(
              fontSize: getProportionatefontSize(12),
              color: Color(0xff1F2230).withOpacity(0.64),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          width: getProportionateScreenWidth(334),
          color: Colors.white,
          child: TextFormField(
            focusNode: _focusDateField,
            validator: (value) =>
                value.isEmpty ? "Date of birth cannot be empty" : null,
            controller: controller,
            onTap: callBack,
            decoration: InputDecoration(
              prefixIcon: Icon(JalsIcons.date),
              hintText: "31/07/1986",
              contentPadding: const EdgeInsets.only(top: 7),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
