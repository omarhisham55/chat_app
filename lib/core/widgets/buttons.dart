import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final EdgeInsets? buttonPadding;
  final EdgeInsets? textPadding;
  final bool? isButtonSmall;
  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.buttonPadding,
    this.textPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.isButtonSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: buttonPadding,
      child: MaterialButton(
        onPressed: onPressed,
        padding: textPadding,
        color: backgroundColor ?? AppColors.lightThemePrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isButtonSmall! ? MainAxisSize.min : MainAxisSize.max,
          children: [
            SizedBox(
              height: icon != null ? 16 : 0,
              child: icon ?? Container(),
            ),
            Text(
              text,
              style: isButtonSmall!
                  ? Theme.of(context).textTheme.titleSmall
                  : Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
