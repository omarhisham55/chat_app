import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<SplashScreenCubit>(context).allUsers.isEmpty) {
      return Center(
        child: Text(
          "No Users found",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    } else {
      return BlocBuilder<ChatPageCubit, ChatPageState>(
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _chatListItem(
              context: context,
              user: BlocProvider.of<SplashScreenCubit>(context).allUsers[index],
              focusColor: BlocProvider.of<ChatPageCubit>(context)
                  .chatBackgroundColor(context)[index],
              onLongPress: () =>
                  BlocProvider.of<ChatPageCubit>(context).selectedChat(
                context,
                index,
                BlocProvider.of<SplashScreenCubit>(context).allUsers[index],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount:
                BlocProvider.of<SplashScreenCubit>(context).allUsers.length,
          );
        },
      );
    }
  }

  Widget _chatListItem({
    required BuildContext context,
    required User user,
    required Color focusColor,
    required Function() onLongPress,
  }) =>
      InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.intoChatRoute,
          arguments: user,
        ),
        onLongPress: onLongPress,
        child: Container(
          color: focusColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<ChatPageCubit, ChatPageState>(
                builder: (context, state) {
              final List<Chat> messages =
                  BlocProvider.of<ChatPageCubit>(context).messages;
              final String finalMessage = messages.isNotEmpty
                  ? messages.last.message
                  : "getting message...";
              final String finalDateTime =
                  messages.isNotEmpty ? messages.last.dateTime : "";
              return Row(
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
                            user.username,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            finalMessage,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
                        finalDateTime,
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
                          "1",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.whiteBackgroundColor),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      );
}
