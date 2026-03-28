import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/view/dashboard_view.dart';

class EditCharacterView extends ConsumerWidget {
  const EditCharacterView({super.key,required this.index});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editCharacterProvider);
    final controller = ref.read(editCharacterProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,onPopInvoked) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashboardView(selectIndex: 1)),
              (Route<dynamic> route) => false,
        );
        ref.refresh(favoriteProvider);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DashboardView(selectIndex: 1)),
                    (Route<dynamic> route) => false,
              );
              ref.refresh(favoriteProvider);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white70,),
          ),
          title: const Text("Edit Character"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              _inputField("Name", state.nameController),
              _inputField("Species", state.speciesController),
              _inputField("Status", state.statusController),
              _inputField("Gender", state.genderController),
              _inputField("Type", state.typeController),
              _inputField("Location", state.locationController),
              _inputField("Origin", state.originController),

              const SizedBox(height: 30),

              // ✅ Save Button
              SizedBox(
                width: double.infinity,
                child: state.isLoading == true ?
                Center(
                  child: CircularProgressIndicator(),
                ) :
                ElevatedButton(
                  onPressed: () {
                    print(index);
                    print(state.nameController.text);
                    print(state.speciesController.text);
                    print(state.statusController.text);
                    print(state.genderController.text);
                    print(state.typeController.text);
                    print(state.locationController.text);
                    print(state.originController.text);
                    controller.editCharacter(
                      context: context,
                      id: index,
                      name: state.nameController.text == "" ? null : state.nameController.text,
                      species: state.speciesController.text == "" ? null : state.speciesController.text,
                      status: state.statusController.text == "" ? null : state.statusController.text,
                      gender: state.genderController.text == "" ? null : state.genderController.text,
                      type: state.typeController.text == "" ? null : state.typeController.text,
                      location: state.locationController.text == "" ? null : state.locationController.text,
                      origin: state.originController.text == "" ? null : state.originController.text,
                    );
                    // handle save
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF1A1C2C),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

