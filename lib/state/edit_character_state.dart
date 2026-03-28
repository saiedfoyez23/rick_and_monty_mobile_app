import 'package:flutter/cupertino.dart';

class EditCharacterState {
  final bool isLoading;
  final TextEditingController nameController;
  final TextEditingController statusController;
  final TextEditingController speciesController;
  final TextEditingController typeController;
  final TextEditingController genderController;
  final TextEditingController originController;
  final TextEditingController locationController;

  const EditCharacterState({
    this.isLoading = false,
    required this.nameController,
    required this.statusController,
    required this.speciesController,
    required this.typeController,
    required this.genderController,
    required this.originController,
    required this.locationController,
  });

  EditCharacterState copyWith({
    bool? isLoading,
    TextEditingController? nameController,
    TextEditingController? statusController,
    TextEditingController? speciesController,
    TextEditingController? typeController,
    TextEditingController? genderController,
    TextEditingController? originController,
    TextEditingController? locationController,
  }) {
    return EditCharacterState(
      isLoading: isLoading ?? this.isLoading,
      nameController: nameController ?? this.nameController,
      statusController: statusController ?? this.statusController,
      speciesController: speciesController ?? this.speciesController,
      typeController: typeController ?? this.typeController,
      genderController: genderController ?? this.genderController,
      originController: originController ?? this.originController,
      locationController: locationController ?? this.locationController,
    );
  }
}