import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';

import '../../../utils/size_config.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final bool isPassword;
  final Color fieldColor;

  AuthTextField({
    Key key,
    @required this.prefixIcon,
    @required this.fieldColor,
    @required this.keyboardType,
    @required this.controller,
    @required this.hintText,
    @required this.title,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool obscure;

  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
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
          color: widget.fieldColor,
          child: Theme(
            data: ThemeData(primaryColor: Colors.blue),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "${widget.title} cannot be empty";
                }
                if (widget.validator != null) return widget.validator(value);
                return null;
              },
              obscureText: obscure,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? obscure
                        ? InkWell(
                            onTap: toggleObscure, child: Icon(Icons.visibility))
                        : InkWell(
                            onTap: toggleObscure,
                            child: Icon(Icons.visibility_off))
                    : SizedBox(),
                prefixIcon: Icon(widget.prefixIcon),
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.only(top: 7),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }
}

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final bool isPassword;
  final Color fieldColor;

  SearchTextField({
    Key key,
    @required this.prefixIcon,
    @required this.fieldColor,
    @required this.keyboardType,
    @required this.controller,
    @required this.hintText,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool obscure;

  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: getProportionateScreenWidth(334),
          color: widget.fieldColor,
          child: Theme(
            data: ThemeData(primaryColor: Colors.blue),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "search field cannot be empty";
                }
                if (widget.validator != null) return widget.validator(value);
                return null;
              },
              obscureText: obscure,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: widget.isPassword
                    ? obscure
                        ? InkWell(
                            onTap: toggleObscure, child: Icon(Icons.visibility))
                        : InkWell(
                            onTap: toggleObscure,
                            child: Icon(Icons.visibility_off))
                    : SizedBox(),
                prefixIcon: Icon(widget.prefixIcon),
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.only(top: 7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }
}
