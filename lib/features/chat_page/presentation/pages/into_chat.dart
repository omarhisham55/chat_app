import 'package:chat_app/core/widgets/text_form_field.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/features/chat_page/presentation/widgets/chat_bubble.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
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

  Widget _buildBody(context) => ListView.builder(
        itemBuilder: (context, index) => const Column(
          children: [
            UserBubbleChat(),
            OtherBubbleChat(),
          ],
        ),
      );

  Widget _typeMessage(context) => MessagesTextField(
        controller: BlocProvider.of<ChatPageCubit>(context).messageController,
      );
}
