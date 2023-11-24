import 'dart:io';

import 'package:chat_app/features/settings/domain/usecases/profile_photo_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ProfilePhotoUsecase profilePhotoUsecase;
  SettingsCubit({required this.profilePhotoUsecase}) : super(SettingsInitial());

  final ImagePicker imagePicker = ImagePicker();
  Future<File?> selectProfileImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future saveProfileImage(File file) async {
    final response = await profilePhotoUsecase.call(file);
    response.fold(
      (l) => SaveProfilePhotoFailed(),
      (r) => SaveProfilePhotoSuccess(r),
    );
  }
}
