import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_mobile_app/controller/home_controller.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/state/home_state.dart';
import 'package:rick_and_morty_mobile_app/view/character_details_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final controller = ref.read(homeProvider.notifier);


    ref.listen<HomeState>(homeProvider, (prev, next) {
      if (next.error != null && next.error != prev?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });


    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
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
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200) {
                    controller.fetchNextPage();
                  }
                  return false;
                },
                child: GridView.builder(
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
                ),
              ),
            ),
          ),

          Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
            child: Center(
              child: state.isLoadMore
                  ? const CircularProgressIndicator()
                  : state.hasMore
                  ? const SizedBox()
                  : const Text("No more data"),
            ),
    )
        ],
      ),
    );
  }

  Widget _characterCard({
    required HomeState state,
    required HomeController controller,
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
            MaterialPageRoute(builder: (context) => CharacterDetailView(rickAndMortyApiAllResponseResults: character,isHome: true,)),
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
