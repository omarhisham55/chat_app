import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SliverAppBar navigationAppbar(context, PreferredSize bottom) {
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
    bottom: bottom,
    elevation: 0.0,
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
            String() => '',
          },
        ),
        splashRadius: 25,
        itemBuilder: (BuildContext context) => popUpMenuEntries,
      ),
    ],
  );
}

SliverAppBar toArchiveAppbar(context, PreferredSize bottom) {
  return SliverAppBar(
    pinned: true,
    leading: IconButton(
      onPressed: () =>
          BlocProvider.of<ChatPageCubit>(context).clearAllSelectedChat(),
      icon: Icon(Icons.adaptive.arrow_back_rounded),
    ),
    title: Text(
      BlocProvider.of<ChatPageCubit>(context)
          .selectedChatList
          .length
          .toString(),
    ),
    bottom: bottom,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.push_pin),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.delete),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.volume_off),
      ),
      IconButton(
        onPressed: () => BlocProvider.of<ChatPageCubit>(context).addToArchive(),
        icon: const Icon(Icons.archive),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.adaptive.more),
      ),
    ],
  );
}
