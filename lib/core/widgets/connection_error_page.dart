import 'package:chat_app/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ConnectionErrorPage extends StatelessWidget {
  const ConnectionErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.signal_wifi_connected_no_internet_4_sharp),
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: Text(
            "No internet connection. Please connect to the internet.",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        RoundedButton(
          text: "try again",
          onPressed: () {},
        ),
      ],
    );
  }
}
