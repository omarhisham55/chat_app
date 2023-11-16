import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class UserBubbleChat extends StatelessWidget {
  const UserBubbleChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          margin: const EdgeInsets.only(left: 50),
          decoration: BoxDecoration(
            color: AppColors.lightThemeThirdColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  "message.text",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 10.0),
                Text(
                  "message.dateTime",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherBubbleChat extends StatelessWidget {
  const OtherBubbleChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          margin: const EdgeInsets.only(right: 50),
          decoration: const BoxDecoration(
            color: AppColors.whiteBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  "message.text",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 10.0),
                Text(
                  "message.dateTime",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
