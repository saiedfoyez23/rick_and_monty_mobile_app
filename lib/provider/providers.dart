import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/controller/character_details_controller.dart';
import 'package:rick_and_morty_mobile_app/controller/dashboard_controller.dart';
import 'package:rick_and_morty_mobile_app/controller/favorites_controller.dart';
import 'package:rick_and_morty_mobile_app/controller/home_controller.dart';
import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';
import 'package:rick_and_morty_mobile_app/state/dashboard_state.dart';
import 'package:rick_and_morty_mobile_app/state/favorites_state.dart';
import 'package:rick_and_morty_mobile_app/state/home_state.dart';

import '../state/character_details_state.dart';

// dashboard provider

final dashboardProvider = StateNotifierProvider.family<DashboardController, DashboardState, int>((ref, index) {
  return DashboardController(selectedIndex: index,ref: ref);
});

final homeProvider = StateNotifierProvider<HomeController, HomeState>(
      (ref) => HomeController(ref),
);


final characterDetailsProvider = StateNotifierProvider.family<CharacterDetailsController, CharacterDetailsState, RickAndMortyApiAllResponseResults>((ref, result) {
  return CharacterDetailsController(selectResult: result,ref: ref);
});


final favoriteProvider = StateNotifierProvider<FavoritesController, FavoritesState>(
      (ref) => FavoritesController(ref),
);