import 'package:chat_app/features/settings/presentation/widgets/setting_details_page_body_widgets/account.dart';
import 'package:chat_app/injection_container.dart';

Future<void> settingsInjection() async {
  injection.registerLazySingleton(
    () => AccountBodyContent(sharedPreferences: injection()),
  );
}
