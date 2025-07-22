import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavBarState> {
  NavigationCubit() : super(NavBarInitialState());
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
