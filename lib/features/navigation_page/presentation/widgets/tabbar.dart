import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigationTabbar extends StatefulWidget {
  final int length;
  final List<String> tabTitles;
  final List<Widget> tabBodies;
  const NavigationTabbar({
    super.key,
    required this.length,
    required this.tabTitles,
    required this.tabBodies,
  });

  @override
  State<NavigationTabbar> createState() => _NavigationTabbarState();
}

class _NavigationTabbarState extends State<NavigationTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: null,
        actions: null,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.whiteBackgroundColor,
            indicatorWeight: 4,
            tabs: List.generate(
              widget.length,
              (index) => Tab(
                text: widget.tabTitles[index],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          widget.length,
          (index) => widget.tabBodies[index],
        ),
      ),
    );
  }
}
