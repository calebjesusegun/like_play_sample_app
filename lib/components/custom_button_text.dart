import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/constants/app_colors.dart';

class ButtonText extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle style;

  const ButtonText(
      {required this.label, required this.onPressed, required this.style});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: kWhite,
      borderRadius: BorderRadius.circular(15.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          // side: const BorderSide(color: kSecondaryColor, width: 0.1),
        ),
        onPressed: onPressed,
        minWidth: 8.0, //8.0
        height: 52.0,
        textColor: kWhite,
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}
