import 'package:chat_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  _profileBody(_) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const Hero(
                    tag: "profile",
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 70,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () => BlocProvider.of<SettingsCubit>(_)
                          .selectProfileImage(),
                      splashRadius: 25,
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: _profileBody(context),
    );
  }
}
