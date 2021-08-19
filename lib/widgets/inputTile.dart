import "package:flutter/material.dart";

import 'package:flutter/services.dart';
import 'package:storage_cloud/utilities/constants.dart';

//created by aksh
// ignore: must_be_immutable
class InputTile extends StatelessWidget {
  InputTile(
      {this.isObscure = false,
      this.startIcon,
      this.tileIcon,
      @required this.inputType,
      @required this.callBack,
      this.textLength,
      this.tapCall,
      this.keyboard,
      this.setValidator,
      this.seeOnly = false,
      this.control});
  Icon startIcon;
  Function setValidator;
  Function callBack;
  Function tapCall;
  final String inputType;
  final bool isObscure;
  var control;
  bool seeOnly;
  final TextInputType keyboard;
  final IconButton tileIcon;
  final List<TextInputFormatter> textLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      inputFormatters: textLength,
      style: kTextFieldStyle,
      controller: control,
      readOnly: seeOnly,
      cursorColor: kPrimaryColor,
      validator: setValidator,
      onChanged: callBack,
      onTap: tapCall,
      obscureText: isObscure,
      decoration: InputDecoration(
        fillColor: Colors.grey[700],
        prefixIcon: startIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.5),
        ),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        hintText: inputType,
        hintStyle: kHintTextStyle,
        suffixIcon: tileIcon,
        border: OutlineInputBorder(
          borderRadius: kTextFieldBorderRadius,
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
      ),
    );
  }
}
