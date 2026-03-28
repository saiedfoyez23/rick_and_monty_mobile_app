import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';

class CharacterDetailsState {
  final RickAndMortyApiAllResponseResults selectResult;
  final List<RickAndMortyApiAllResponseResults> items;
  final bool isLoading;

  const CharacterDetailsState({
    required this.selectResult,
    this.items = const [],
    this.isLoading = false,
  });

  CharacterDetailsState copyWith({
    RickAndMortyApiAllResponseResults? selectResult,
    List<RickAndMortyApiAllResponseResults>? items,
    bool? isLoading,
  }) {
    return CharacterDetailsState(
      selectResult: selectResult ?? this.selectResult,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading
    );
  }
}