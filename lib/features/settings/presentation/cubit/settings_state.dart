part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SaveProfilePhotoFailed extends SettingsState {}

class SaveProfilePhotoSuccess extends SettingsState {
  final UploadTask uploadTask;
  const SaveProfilePhotoSuccess(this.uploadTask);

  @override
  List<Object> get props => [uploadTask];
}
