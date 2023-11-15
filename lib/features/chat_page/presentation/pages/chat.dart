import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/chat_list.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  _archiveBar(context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              Icons.archive_outlined,
              color: AppColors.shadedColor,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  AppStrings.archived,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.shadedColor),
                ),
              ),
            ),
            Text(
              "4",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.lightThemeSecondaryColor),
            ),
          ],
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _archiveBar(context),
            const ChatList(),
          ],
        ),
      ),
    );
  }
}
