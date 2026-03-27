import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/state/dashboard_state.dart';
import 'package:rick_and_morty_mobile_app/view/favorites_view.dart';
import 'package:rick_and_morty_mobile_app/view/home_view.dart';

class DashboardController extends StateNotifier<DashboardState> {
  final Ref ref;
  final int selectedIndex;

  DashboardController({required this.selectedIndex,required this.ref}) : super(DashboardState(
      selectIndex: selectedIndex,
      pages: [
        HomeView(),
        FavoritesView(),
      ],
  )) {
    _init(selectedIndex);
  }

  Future<void> _init(int index) async {
    await Future.delayed(const Duration(milliseconds: 10));
    changeIndex(index);
  }

  void changeIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }

}