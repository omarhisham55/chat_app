import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationTabbar extends StatefulWidget {
  TabController tabController;
  final int length;
  final List<String> tabTitles;
  NavigationTabbar({
    super.key,
    required this.tabController,
    required this.length,
    required this.tabTitles,
  });

  @override
  State<NavigationTabbar> createState() => _NavigationTabbarState();
}

class _NavigationTabbarState extends State<NavigationTabbar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.tabController = TabController(length: widget.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.tabController.dispose();
  }

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kTextTabBarHeight),
      child: TabBar(
        controller: widget.tabController,
        indicatorColor: AppColors.whiteBackgroundColor,
        indicatorWeight: 4,
        tabs: List.generate(
          widget.length,
          (index) => Tab(
            text: widget.tabTitles[index],
          ),
        ),
      ),
    );
  }
}
