import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/widgets/indicator.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition:
            BlocProvider.of<WelcomePageCubit>(context).allUsers.isNotEmpty,
        fallback: (context) => const LoadingIndicator(),
        builder: (context) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _chatListItem(
              context,
              BlocProvider.of<WelcomePageCubit>(context).allUsers[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount:
                BlocProvider.of<WelcomePageCubit>(context).allUsers.length,
          );
        });
  }

  Widget _chatListItem(context, User user) => InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.intoChatRoute,
          arguments: user,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        BlocProvider.of<ChatPageCubit>(context)
                            .messages
                            .last
                            .message,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                    "8:35 pm",
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
                      "2",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.whiteBackgroundColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
