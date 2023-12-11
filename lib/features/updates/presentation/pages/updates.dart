import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:flutter/material.dart';

class Updates extends StatelessWidget {
  const Updates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _row1(context),
            _row2(context),
            Text(
              "Recent updates",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.shadedColor),
            ),
            _statusList(context),
          ],
        ),
      ),
    );
  }

  Widget _row1(_) => Row(
        children: [
          Expanded(
            child: Text(
              "Status",
              style: Theme.of(_)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.adaptive.more),
          ),
        ],
      );

  Widget _row2(_, {String? username, Color? avatar}) => Container(
        margin: username == null
            ? const EdgeInsets.symmetric(vertical: 20)
            : const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: avatar ?? AppColors.shadedColor,
                ),
                if (avatar == null)
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 15.5,
                        backgroundColor: AppColors.whiteBackgroundColor,
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.lightThemePrimaryColor,
                        child: const Icon(
                          Icons.add,
                          color: AppColors.whiteBackgroundColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? "My status",
                    style: Theme.of(_)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    "Tap to add status update",
                    style: Theme.of(_)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.shadedColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _statusList(_) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _row2(
          _,
          username: SplashScreenCubit.allUsers![index].username,
          avatar: AppColors.lightThemePrimaryColor,
        ),
        itemCount: SplashScreenCubit.allUsers!.length,
      );
}
