import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  bool obscure;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Color fieldColor;

  CustomTextField(
      {Key key,
      @required this.suffixIcon,
      this.obscure = false,
      @required this.fieldColor,
      @required this.keyboardType,
      @required this.prefixIcon,
      @required this.controller,
      @required this.hintText,
      @required this.title,
      @required this.onSaved,
      @required this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
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
          // height: getProportionatefontSize(51),
          width: getProportionateScreenWidth(334),
          decoration: BoxDecoration(
            color: fieldColor,
            // border: Border.all(
            //   color: Colors.blue,
            // ),
          ),
          child: Theme(
            data: ThemeData(primaryColor: Colors.blue),
            child: TextFormField(
              validator: validator,
              obscureText: obscure,
              onSaved: onSaved,
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                hintText: hintText,
                contentPadding: const EdgeInsets.only(top: 7),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
