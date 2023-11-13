import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:flutter/material.dart';

SliverAppBar navigationAppbar(context) {
  List<PopupMenuEntry<String>> popUpMenuEntries =
      SettingStrings.settingsNavigationAppbar
          .map(
            (value) => PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
          .toList();
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
            "Settings" => Routes.settingsRoute,
            String() => null,
          }!,
        ),
        splashRadius: 25,
        itemBuilder: (BuildContext context) => popUpMenuEntries,
      ),
    ],
  );
}
