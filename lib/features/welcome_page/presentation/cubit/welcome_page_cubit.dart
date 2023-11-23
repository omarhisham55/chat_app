import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'welcome_page_state.dart';

class WelcomePageCubit extends Cubit<WelcomePageState> {
  WelcomePageCubit() : super(WelcomePageInitial());
}
