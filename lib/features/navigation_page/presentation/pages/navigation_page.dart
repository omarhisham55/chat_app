import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/chat_page/presentation/pages/chat.dart';
import 'package:chat_app/features/navigation_page/presentation/widgets/navigation_appbar.dart';
import 'package:chat_app/features/navigation_page/presentation/widgets/tabbar.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          navigationAppbar(context),
        ],
        body: const NavigationTabbar(
          length: 3,
          tabTitles: [
            AppStrings.chats,
            AppStrings.updates,
            AppStrings.calls,
          ],
          tabBodies: [
            ChatPage(),
            ChatPage(),
            ChatPage(),
          ],
        ),
      ),
    );
  }
}
