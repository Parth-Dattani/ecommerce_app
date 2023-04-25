import 'package:ecommerce_app/constant/constant.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final bool isObscure;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const CommonTextField({
    Key? key,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.hintText,
    this.isObscure = false,
    this.validator,
    this.hintTextStyle,
    this.borderRadius,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: ColorConfig.colorBlur,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),),
      validator: validator,
      obscureText: isObscure,
    );
  }
}
