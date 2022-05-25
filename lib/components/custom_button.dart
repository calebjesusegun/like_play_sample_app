import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/constants/app_colors.dart';
import 'package:likeplay_likeplay_chat_app/constants/text_styles.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  const CustomButton(
      {Key? key, required this.label, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 8.0, //8.0
          height: 52.0,
          textColor: kWhite,
          child: Text(
            label,
            style: kButtonLabelStyleMain,
          ),
        ),
      ),
    );
  }
}
