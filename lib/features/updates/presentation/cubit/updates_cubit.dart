import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'updates_state.dart';

class UpdatesCubit extends Cubit<UpdatesState> {
  UpdatesCubit() : super(UpdatesInitial());
}
