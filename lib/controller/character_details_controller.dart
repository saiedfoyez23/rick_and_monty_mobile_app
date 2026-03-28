import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/local_storage/store_charecter_response.dart';
import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/state/character_details_state.dart';

import '../view/dashboard_view.dart';

class CharacterDetailsController extends StateNotifier<CharacterDetailsState> {
  final Ref ref;
  final RickAndMortyApiAllResponseResults selectResult;

  CharacterDetailsController({required this.selectResult,required this.ref}) : super(CharacterDetailsState(
    selectResult: selectResult,
  )) {
    _init();
  }

  Future<void> _init() async {
    await StoreCharacterResponse.getCharacterList().then((value) {
      print(value.length);
      print(value.isNotEmpty);
      if(value.isNotEmpty == true) {
        state = state.copyWith(items: value);
      }
    });
  }

  Future<void> addCharacter({
    required RickAndMortyApiAllResponseResults result,
    required BuildContext context
  }) async {
    state = state.copyWith(isLoading: true);
    await StoreCharacterResponse.saveCharacter(newCharacter: result);
    Future.delayed(Duration(microseconds: 100),() async {
      state = state.copyWith(isLoading: false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardView(selectIndex: 1)),
            (Route<dynamic> route) => false,
      );
      ref.refresh(favoriteProvider);
    });
  }

}