import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';
import 'package:rick_and_morty_mobile_app/state/home_state.dart';
import 'package:rick_and_morty_mobile_app/utils/api_utils.dart';
import 'package:rick_and_morty_mobile_app/utils/base_api_utils.dart';

class HomeController extends StateNotifier<HomeState> {
  final Ref ref;

  HomeController(this.ref) : super(const HomeState()) {
    init();
  }

  void init() async {
    await fetchFirstPage();
  }

  // 🔹 First Load
  Future<void> fetchFirstPage() async {
    state = state.copyWith(isLoading: true, page: 1, items: []);

    await _fetch(page: 1);
  }

  // 🔹 Load More
  Future<void> fetchNextPage() async {
    if (state.isLoadMore || !state.hasMore) return;

    state = state.copyWith(isLoadMore: true);

    await _fetch(page: state.page + 1);
  }

  // 🔹 Core API Call
  Future<void> _fetch({required int page}) async {
    BaseApiUtils.get(
      url: ApiUtils.getAllCharacter(page),
      onSuccess: (e, data) {
        final response = RickAndMortyApiAllResponseModel.fromJson(data);

        final newItems = response.results ?? [];

        state = state.copyWith(
          isLoading: false,
          isLoadMore: false,
          page: page,
          items: page == 1
              ? newItems
              : [...state.items, ...newItems],
          hasMore: newItems.isNotEmpty, // simple check
        );
      },
      onFail: (e, data) {
        state = state.copyWith(
          isLoading: false,
          isLoadMore: false,
          error: e,
        );
      },
      onExceptionFail: (e, data) {
        state = state.copyWith(
          isLoading: false,
          isLoadMore: false,
          error: e,
        );
      },
    );
  }
}