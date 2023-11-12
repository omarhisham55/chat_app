import 'package:chat_app/features/navigation_page/presentation/widgets/navigation_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          navigationAppbar,
        ],
        body: Column(
          children: [
            TextButton(
                onPressed: () async{
                  await sharedPreferences.then((value) => value.remove("userId"));
                },
                child: Text("logout"))
          ],
        ),
      ),
    );
  }
}
