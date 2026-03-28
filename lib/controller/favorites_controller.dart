import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty_mobile_app/local_storage/store_charecter_response.dart';
import 'package:rick_and_morty_mobile_app/state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final Ref ref;

  FavoritesController(this.ref) : super(const FavoritesState()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    Future.delayed(Duration(seconds: 1),() async {
      state = state.copyWith(isLoading: false);
      await StoreCharacterResponse.getCharacterList().then((value) {
        print(value.length);
        print(value.isNotEmpty);
        if(value.isNotEmpty == true) {
          state = state.copyWith(items: value);
        }
      });
    });
  }


}