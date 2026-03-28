import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/local_storage/store_charecter_response.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/state/edit_character_state.dart';
import 'package:rick_and_morty_mobile_app/view/dashboard_view.dart';

class EditCharacterController extends StateNotifier<EditCharacterState> {
  final Ref ref;

  EditCharacterController({required this.ref}) : super(EditCharacterState(
    nameController: TextEditingController(),
    speciesController: TextEditingController(),
    statusController: TextEditingController(),
    genderController: TextEditingController(),
    typeController: TextEditingController(),
    locationController: TextEditingController(),
    originController: TextEditingController(),
  ));

  Future<void> editCharacter({
    required BuildContext context,
    required int id,
    String? name,
    String? species,
    String? status,
    String? gender,
    String? type,
    String? location,
    String? origin,
  }) async {
    state = state.copyWith(isLoading: true);
    await StoreCharacterResponse.updateCharacter(
      id: id,
      name: name,
      species: species,
      status: status,
      gender: gender,
      type: type,
      location: location,
      origin: origin,
    );
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