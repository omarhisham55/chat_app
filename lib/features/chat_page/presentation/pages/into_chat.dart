import 'package:chat_app/core/widgets/indicator.dart';
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

  Widget _buildBody(context) => StreamBuilder(
        stream: BlocProvider.of<ChatPageCubit>(context)
            .getChat(context: context, receiverId: otherUser.id),
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data == null) {
            return BlocBuilder<ChatPageCubit, ChatPageState>(
                builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: ListView.builder(
                  itemCount:
                      BlocProvider.of<ChatPageCubit>(context).messages.length,
                  itemBuilder: (context, index) {
                    // List<Chat> messages = snapshot.data;
                    Chat message =
                        BlocProvider.of<ChatPageCubit>(context).messages[index];
                    print('hamada $message');
                    if (BlocProvider.of<WelcomePageCubit>(context)
                            .userModel!
                            .id ==
                        message.senderId) {
                      return UserBubbleChat(
                        message: message.message,
                        dateTime: message.dateTime,
                      );
                    } else {
                      return OtherBubbleChat(
                        message: message.message,
                        dateTime: message.dateTime,
                      );
                    }
                  },
                ),
              );
            });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          } else {
            return const LoadingIndicator();
          }
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
