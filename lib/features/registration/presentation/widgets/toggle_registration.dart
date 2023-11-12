import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ToggleRegistration extends StatelessWidget {
  final String text;
  final String buttonText;
  final Function() onTap;
  const ToggleRegistration({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.lightThemePrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
