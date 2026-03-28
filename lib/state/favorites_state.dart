import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';

class FavoritesState {
  final bool isLoading;
  final List<RickAndMortyApiAllResponseResults> items;

  const FavoritesState({
    this.isLoading = false,
    this.items = const [],
  });

  FavoritesState copyWith({
    bool? isLoading,
    List<RickAndMortyApiAllResponseResults>? items,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}