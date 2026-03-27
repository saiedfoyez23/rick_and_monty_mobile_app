import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/controller/dashboard_controller.dart';
import 'package:rick_and_morty_mobile_app/state/dashboard_state.dart';

// dashboard provider

final dashboardProvider = StateNotifierProvider.family<DashboardController, DashboardState, int>((ref, index) {
  return DashboardController(selectedIndex: index,ref: ref);
});