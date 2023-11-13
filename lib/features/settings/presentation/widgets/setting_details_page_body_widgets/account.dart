import 'package:chat_app/config/routes/routes.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBodyContent extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const AccountBodyContent({super.key, required this.sharedPreferences});

  _buttonOnTap(BuildContext context, int index) => switch (index) {
        5 => {
            sharedPreferences.remove("userId"),
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signUpRoute,
              (route) => false,
            ),
          },
        int() => null,
      };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: SettingStrings.accountBodyContent.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => _buttonOnTap(context, index),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                SettingStrings.accountBodyContent.values.elementAt(index),
                size: 30,
              ),
            ),
            Text(
              SettingStrings.accountBodyContent.keys.elementAt(index),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
