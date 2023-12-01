import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/chat_page/presentation/pages/chat.dart';
import 'package:chat_app/features/navigation_page/presentation/widgets/navigation_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  late final PreferredSize _bottomAppbar = PreferredSize(
    preferredSize: const Size.fromHeight(kTextTabBarHeight),
    child: TabBar(
      controller: _tabController,
      indicatorColor: AppColors.whiteBackgroundColor,
      indicatorWeight: 4,
      tabs: List.generate(
        3,
        (index) => Tab(
          text: AppStrings.tabTitles[index],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatPageCubit, ChatPageState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              BlocProvider.of<ChatPageCubit>(context).selectedChatList.isEmpty
                  ? navigationAppbar(context, _bottomAppbar)
                  : toArchiveAppbar(context, _bottomAppbar),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                ChatPage(),
                ChatPage(),
                ChatPage(),
              ],
            ),
          );
        },
      ),
    );
  }
}
