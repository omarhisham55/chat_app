import 'package:chat_app/features/settings/presentation/widgets/setting_details_page_body_widgets/account.dart';
import 'package:chat_app/features/settings/presentation/widgets/setting_details_page_body_widgets/privacy.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/injection_container.dart' as di;

class SettingDetailPage extends StatelessWidget {
  final String title;
  const SettingDetailPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _bodyContent(context, title),
    );
  }

  Widget? _bodyContent(_, String title) => switch (title) {
        "Account" => AccountBodyContent(sharedPreferences: di.injection()),
        "Privacy" => const PrivacyBodyContent(),
        String() => null,
      };
}
