import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_mobile_app/controller/favorites_controller.dart';
import 'package:rick_and_morty_mobile_app/state/favorites_state.dart';

import '../provider/providers.dart';
import 'character_details_view.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteProvider);
    final controller = ref.read(favoriteProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.info_outline,size: 23,color: Colors.white70,),
          SizedBox(width: 15,)
        ],
      ),
      body: state.isLoading ?
      const Center(child: CircularProgressIndicator()) :
      Column(
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: state.items.isNotEmpty == true ?
              GridView.builder(
                itemCount: state.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (_, index) {
                  return _characterCard(state: state,controller: controller,index: index,context: context,ref: ref);
                },
              ) :
              Center(
                child: Text("No Favorites"),
              ),
            ),
          ),

          SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _characterCard({
    required FavoritesState state,
    required FavoritesController controller,
    required int index,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    var character = state.items[index];
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          ref.refresh(characterDetailsProvider(character));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CharacterDetailView(rickAndMortyApiAllResponseResults: character,isHome: false,)),
                (Route<dynamic> route) => false,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                character.name,
                style: TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                character.status == "Alive" ? "Alive" : "Unknown",
                style: TextStyle(color: character.status == "Alive" ? Colors.green : Colors.red, fontSize: 12),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

