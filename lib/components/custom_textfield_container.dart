import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RoundedInputField extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final Widget? suffixIcon;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool? isReadOnly;
  final double width;
  const RoundedInputField({
    Key? key,
    // Key key,
    required this.labelText,
    this.icon,
    this.suffixIcon,
    required this.onChanged,
    this.onTap,
    this.focusNode,
    this.controller,
    this.isReadOnly,
    required this.width,
  }) : super(key: key); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      width: width,
      decoration: BoxDecoration(
        color: kSecondaryColor20,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onTap: onTap,
        readOnly: isReadOnly ?? false,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          icon: icon != null
              ? Icon(
                  icon,
                  color: kSecondaryColor,
                )
              : null,
          suffixIcon: suffixIcon,
          suffixIconColor: kSecondaryColor,
          // hintText: hintText,
          border: InputBorder.none,
          labelText: labelText,
        ),
      ),
    );
  }
}
