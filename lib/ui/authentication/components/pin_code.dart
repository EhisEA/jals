import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/utils/colors_utils.dart';

import 'pin_code_text_field.dart';
import 'pin_theme.dart';

class PinTextField extends StatefulWidget {
  final TextEditingController controller;
  const PinTextField({Key key, @required this.controller}) : super(key: key);

  @override
  _PinTextFieldState createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: PinCodeTextField(
        textInputType: TextInputType.number,
        backgroundColor: Colors.transparent,
        length: 4,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        obsecureText: false,
        animationType: AnimationType.fade,

        pinTheme: PinTheme(
          // fieldHeight: 50,
          // fieldWidth: 40,
          activeColor: Colors.transparent, // kPrimaryColor.withOpacity(0.5),
          inactiveFillColor: kPrimaryColor.withOpacity(0.1),
          inactiveColor: Colors.transparent,
          selectedColor: kPrimaryColor.withOpacity(0.6),
          selectedFillColor:
              kPrimaryColor.withOpacity(0.1), //Color(0xffF6F9FC),
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          activeFillColor: kPrimaryColor.withOpacity(0.1),
        ),
        enableActiveFill: true,

        animationDuration: Duration(milliseconds: 300),
        textStyle: TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 30,
        ),

        controller: widget.controller,
        validator: (value) {
          if (value.isEmpty) {
            return "Pin code must be entered!";
          }
          return null;
        },
        onChanged: (value) {
          print(value);
        },
        // dialogConfig: DialogConfig(),
        beforeTextPaste: (text) {
          try {
            if (text.length <= 4) {
              int.parse(text);
              Fluttertoast.showToast(msg: "correct");
              return true;
            }
            Fluttertoast.showToast(msg: "wrong");
            return false;
          } catch (e) {
            Fluttertoast.showToast(msg: "wrong");
            return false;
          }
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
        },
      ),
    );
  }
}
