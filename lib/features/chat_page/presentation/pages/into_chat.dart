import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntoChat extends StatelessWidget {
  final User otherUser;
  const IntoChat({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 10),
            Text(
              otherUser.username,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(Icons.videocam_rounded),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
      body: _buildBody(context),
      bottomSheet: _typeMessage(context),
    );
  }

  Widget _buildBody(context) => BlocBuilder<ChatPageCubit, ChatPageState>(
        builder: (context, state) {
          BlocProvider.of<ChatPageCubit>(context).getChat(
            context: context,
            receiverId: otherUser.id,
          );
          return StreamBuilder<List<Chat>>(
            stream: BlocProvider.of<ChatPageCubit>(context).getChat(
              context: context,
              receiverId: otherUser.id,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error");
              }
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Text("loading...");
              // }
              List<Chat> data = snapshot.data ?? [];
              return ListView(
                padding: const EdgeInsets.only(bottom: 70),
                children: data.map<Widget>((chat) {
                  if (BlocProvider.of<WelcomePageCubit>(context)
                          .userModel!
                          .id ==
                      chat.senderId) {
                    return UserBubbleChat(
                      message: chat.message,
                      dateTime: chat.dateTime,
                    );
                  } else {
                    return OtherBubbleChat(
                      message: chat.message,
                      dateTime: chat.dateTime,
                    );
                  }
                }).toList(),
              );
            },
          );
        },
      );

  Widget _typeMessage(context) => MessagesTextField(
        controller: BlocProvider.of<ChatPageCubit>(context).messageController,
        onSend: () => BlocProvider.of<ChatPageCubit>(context).sendChat(
          context: context,
          receiverId: otherUser.id,
        ),
      );
}
