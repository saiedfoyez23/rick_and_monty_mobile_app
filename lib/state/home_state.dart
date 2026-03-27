import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';

class HomeState {
  final bool isLoading;
  final bool isLoadMore;
  final List<RickAndMortyApiAllResponseResults> items;
  final int page;
  final bool hasMore;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.isLoadMore = false,
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadMore,
    List<RickAndMortyApiAllResponseResults>? items,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}