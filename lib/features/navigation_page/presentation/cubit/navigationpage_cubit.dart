import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigationpage_state.dart';

class NavigationpageCubit extends Cubit<NavigationpageState> {
  NavigationpageCubit() : super(NavigationpageInitial());
}
