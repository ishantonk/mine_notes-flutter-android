import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(HomeNavigationInitial());

  void changeIndex(int index) {
    switch (index) {
      case 0:
        emit(HomeNavigationNotes());
        break;
      case 1:
        emit(HomeNavigationCategory());
        break;
      case 2:
        emit(HomeNavigationArchive());
        break;
      case 3:
        emit(HomeNavigationSettings());
        break;
    }
  }

  // Get the current index of the bottom navigation bar
  int getPageIndex() {
    if (state is HomeNavigationNotes) return 0;
    if (state is HomeNavigationCategory) return 1;
    if (state is HomeNavigationArchive) return 2;
    if (state is HomeNavigationSettings) return 3;
    return 0;
  }
}
