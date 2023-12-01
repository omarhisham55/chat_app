import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/widgets/connection_error_page.dart';
import 'package:chat_app/core/widgets/indicator.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageCubit, ChatPageState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadingGetSavedUserState ||
              state is! LoadingGetAllUsersState ||
              SplashScreenCubit.allUsers != null,
          builder: (context) {
            if (state is GetSavedUserErrorState ||
                state is GetAllUsersErrorState) {
              return const ConnectionErrorPage();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _chatListItem(
                  context: context,
                  user: SplashScreenCubit.allUsers![index],
                  focusColor: BlocProvider.of<ChatPageCubit>(context)
                      .chatBackgroundColor[index],
                  onLongPress: () =>
                      BlocProvider.of<ChatPageCubit>(context).selectedChat(
                    index,
                    SplashScreenCubit.allUsers![index],
                  ),
                  onTapDuringLongPress: () =>
                      BlocProvider.of<ChatPageCubit>(context)
                          .removeSelectedChat(
                    index,
                    SplashScreenCubit.allUsers![index],
                  ),
                ),
                itemCount: SplashScreenCubit.allUsers!.length,
              );
            }
          },
          fallback: (context) => const LoadingIndicator(),
        );
      },
    );
  }

  Widget _chatListItem({
    required BuildContext context,
    required User user,
    required bool focusColor,
    required Function() onLongPress,
    required Function onTapDuringLongPress,
  }) =>
      InkWell(
        onTap: () {
          if (BlocProvider.of<ChatPageCubit>(context)
              .chatBackgroundColor
              .contains(true)) {
            onTapDuringLongPress();
          } else {
            Navigator.pushNamed(
              context,
              Routes.intoChatRoute,
              arguments: user,
            );
          }
        },
        onLongPress: onLongPress,
        child: Container(
          color: focusColor
              ? AppColors.shadedWhiteBackgroundColor
              : AppColors.whiteBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<ChatPageCubit, ChatPageState>(
                builder: (context, state) {
              final List<Chat> messages =
                  BlocProvider.of<ChatPageCubit>(context).messages;
              final String finalMessage =
                  messages.isNotEmpty ? messages.last.message : "";
              final String finalDateTime =
                  messages.isNotEmpty ? messages.last.dateTime : "";
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(radius: 25),
                      Visibility(
                        visible: BlocProvider.of<ChatPageCubit>(context)
                            .selectedChatList
                            .contains(user),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightThemeSecondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: const Icon(
                            Icons.done,
                            color: AppColors.whiteBackgroundColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
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
