import 'package:flutter/material.dart';

class AppStrings {
  static const String appTitle = "WhatsApp";
  static const String undefinedRoute = "Undefined Route";
  static const String chats = "Chats";
  static const String updates = "Updates";
  static const String calls = "Calls";
  static const String archived = "Archived";
}

class SettingStrings {
  static const String settingTitle = "Settings";
  static const Map<String, String> settingContent = {
    "Account": "Security notifications, change number",
    "Privacy": "Block contacts, disappearing messages",
    "Avatar": "Create, edit, profile photo",
    "Chats": "Theme, wallpapers, chat history",
    "Notifications": "Message, group & call tones",
    "Storage and data": "Network usage, auot-download",
    "App language": "English (device's language)",
    "Help": "Help center, contact us, privacy policy",
    "Invite a friend": "",
  };
  static const List<IconData> settingContentIcons = [
    Icons.key,
    Icons.lock,
    Icons.face,
    Icons.chat,
    Icons.notifications,
    Icons.data_saver_off,
    Icons.language,
    Icons.help_outline,
    Icons.people,
  ];
  static Map<String, IconData> accountBodyContent = {
    "Security notifications": Icons.security,
    "Two-step verification": Icons.verified_user_outlined,
    "Change number": Icons.phone_android_outlined,
    "Request account info": Icons.insert_drive_file_outlined,
    "Add account": Icons.person_add_alt_1,
    "Delete account": Icons.delete,
  };
}
