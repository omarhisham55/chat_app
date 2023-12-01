import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigationpage_state.dart';

class NavigationpageCubit extends Cubit<NavigationpageState> {
  NavigationpageCubit() : super(NavigationpageInitial());
}
