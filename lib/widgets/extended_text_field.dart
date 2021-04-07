
import 'package:flutter/material.dart';
import 'package:jals/utils/colors_utils.dart';

class ExtendedTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final String title;
  final bool multiline;
  final Function(String) validator;
  final TextEditingController controller;
  ExtendedTextField({
    @required this.title,
    @required this.controller,
    this.multiline = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
  @override
  _ExtendedTextFieldTextFieldState createState() => _ExtendedTextFieldTextFieldState();
}

class _ExtendedTextFieldTextFieldState extends State<ExtendedTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            maxHeight: 200.0,
            minHeight: widget.multiline ? 20 : 0,
          

          ),
          child: TextFormField(
            maxLines: widget.multiline ? 99999999 : 1,
            // style: TextStyle(color: Colors.white),
            controller: widget.controller,
            validator: (value) {
              if (value.isEmpty) {
                return "${widget.title} cannot be empty";
              }
              if (widget.validator != null) return widget.validator(value);
              return null;
            },
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(13),
              // fillColor: Color(0xff0F1114),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: kPrimaryColor.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
