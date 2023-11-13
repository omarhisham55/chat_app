import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:flutter/material.dart';

SliverAppBar navigationAppbar(context) {
  List<PopupMenuEntry<String>> popUpMenuEntries =
      const <PopupMenuEntry<String>>[
    PopupMenuItem<String>(
      value: 'New group',
      child: Text('New group'),
    ),
    PopupMenuItem<String>(
      value: 'Linked devices',
      child: Text('Linked devices'),
    ),
    PopupMenuItem<String>(
      value: 'Starred messages',
      child: Text('Starred messages'),
    ),
    PopupMenuItem<String>(
      value: 'Settings',
      child: Text('Settings'),
    ),
  ];
  return SliverAppBar(
    title: Text(
      AppStrings.appTitle,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    pinned: false,
    floating: false,
    snap: false,
    actions: [
      IconButton.outlined(
        onPressed: () {},
        splashRadius: 25,
        icon: const Icon(Icons.camera_alt_outlined),
      ),
      IconButton(
        onPressed: () {},
        splashRadius: 25,
        icon: const Icon(Icons.search_outlined),
      ),
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (String value) => Navigator.pushNamed(
          context,
          switch (value) {
            "Settings" => Routes.initialRoute,
            String() => null,
          }!,
        ),
        splashRadius: 25,
        itemBuilder: (BuildContext context) => popUpMenuEntries,
      ),
    ],
  );
}
