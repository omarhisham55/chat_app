import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/widgets/indicator.dart';
import 'package:chat_app/features/welcome_page/presentation/cubit/welcome_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final AppBar _appBar = AppBar(
    title: const Text("Settings"),
    actions: const [Icon(Icons.search)],
  );

  Widget _bodyHeader(_) => BlocBuilder<WelcomePageCubit, WelcomePageState>(
        builder: (context, state) {
          if (state is GetSavedUserSuccessState) {
            return Row(
              children: [
                const CircleAvatar(radius: 30),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.userModel!.username,
                          style: Theme.of(_)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "Status",
                          style: Theme.of(_).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 25,
                  icon: Icon(
                    Icons.qr_code,
                    color: AppColors.lightThemePrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashRadius: 25,
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: AppColors.lightThemePrimaryColor,
                  ),
                ),
              ],
            );
          } else {
            return const LoadingIndicator();
          }
        },
      );

  Widget _bodyContent(_) => Column(
        children: List.generate(
          SettingStrings.settingContent.length,
          (index) => InkWell(
            onTap: () => Navigator.pushNamed(
              _,
              Routes.settingsDetailsRoute,
              arguments: SettingStrings.settingContent.keys.elementAt(index),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      SettingStrings.settingContentIcons[index],
                      size: 35,
                      color: AppColors.shadedColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SettingStrings.settingContent.keys.elementAt(index),
                        style: Theme.of(_)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        SettingStrings.settingContent.values.elementAt(index),
                        style: Theme.of(_).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _bodyHeader(
                context,
              ),
              _bodyContent(context),
            ],
          ),
        ),
      ),
    );
  }
}
