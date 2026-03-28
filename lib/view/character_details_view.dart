import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/view/dashboard_view.dart';

class CharacterDetailView extends ConsumerWidget {
  const CharacterDetailView({super.key,required this.rickAndMortyApiAllResponseResults,required this.isHome});
  final bool isHome;
  final RickAndMortyApiAllResponseResults rickAndMortyApiAllResponseResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterDetailsProvider(rickAndMortyApiAllResponseResults));
    final controller = ref.read(characterDetailsProvider(rickAndMortyApiAllResponseResults).notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,onPopInvoked) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashboardView(selectIndex: 0)),
              (Route<dynamic> route) => false,
        );
        ref.refresh(homeProvider);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => DashboardView(selectIndex: 0)),
                    (Route<dynamic> route) => false,
              );
              ref.refresh(homeProvider);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white70,),
          ),
          title: Text("${state.selectResult.name} ${state.items.length}"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [

            isHome == true ?
            IconButton(
              onPressed: () async {
                await controller.addCharacter(result: state.selectResult,context: context);
              },
              icon: Icon(Icons.favorite_border,size: 23,color: Colors.white70,),
            ) :
            IconButton(
              onPressed: () async {
                await controller.addCharacter(result: state.selectResult,context: context);
              },
              icon: Icon(Icons.edit_road_rounded,size: 23,color: Colors.white70,),
            ),
          ],
        ),
        body: state.isLoading ?
        const Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: Column(
              children: [
                Image.network(
                  state.selectResult.image,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A1C2C),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${state.selectResult.name}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
            
                      const SizedBox(height: 6),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, color: state.selectResult.status == "Alive" ? Colors.green : Colors.red, size: 10),
                          SizedBox(width: 6),
                          Text(state.selectResult.status == "Alive" ? "Alive" : "Unknown"),
                        ],
                      ),
            
                      const SizedBox(height: 20),
            
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2D3E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _infoRow("Species", state.selectResult.species),
                            _infoRow("Gender", state.selectResult.gender),
                          ],
                        ),
                      ),
            
                      const SizedBox(height: 20),
            
                      const Text("ORIGIN", style: TextStyle(color: Colors.white54)),
                      const SizedBox(height: 6),
                      _infoCard(state.selectResult.origin?.name ?? ""),
            
                      const SizedBox(height: 16),
            
                      const Text("LAST KNOWN LOCATION", style: TextStyle(color: Colors.white54)),
                      const SizedBox(height: 6),
                      _infoCard(state.selectResult.location?.name ?? ""),
                      const SizedBox(height: 6),
                      Text("EPISODES (${state.selectResult.episode?.length})", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title: ", style: const TextStyle(color: Colors.white54)),
        Text(value),
      ],
    );
  }

  Widget _infoCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D3E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }
}
