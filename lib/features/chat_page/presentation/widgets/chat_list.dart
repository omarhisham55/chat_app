import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _chatListItem(context),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: 20,
    );
  }

  Widget _chatListItem(context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 25),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "username",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                    Text(
                      "message",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.shadedColor,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "8:35 pm",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.shadedColor),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.lightThemeSecondaryColor,
                  child: Text(
                    "2",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.whiteBackgroundColor),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
