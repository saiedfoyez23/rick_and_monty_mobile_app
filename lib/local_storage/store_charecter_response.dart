import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_mobile_app/model/rick_and_morty_api_all_response_model.dart';

class StoreCharacterResponse {

  static Future<void> saveCharacter({
    required RickAndMortyApiAllResponseResults newCharacter,
  }) async {
    var box = Hive.box<String>("StoreCharacterResponse");
    String? existingData = box.get("characters");
    List<RickAndMortyApiAllResponseResults> existingList = [];

    if (existingData != null) {
      List decoded = jsonDecode(existingData);
      existingList = decoded
          .map((e) => RickAndMortyApiAllResponseResults.fromJson(e))
          .toList();
    }

    existingList.add(newCharacter);

    final Map<int, RickAndMortyApiAllResponseResults> uniqueMap = {};

    for (var item in existingList) {
      if (item.id != null) {
        uniqueMap[item.id] = item;
      }
    }

    List<RickAndMortyApiAllResponseResults> uniqueList =
    uniqueMap.values.toList();

    uniqueList.removeWhere((e) => e.id == newCharacter.id);
    uniqueList.insert(0, newCharacter);

    List<Map<String, dynamic>> jsonList =
    uniqueList.map((e) => e.toJson()).toList();

    print(jsonEncode(jsonList));

    await box.put("characters", jsonEncode(jsonList));
  }

  static Future<List<RickAndMortyApiAllResponseResults>> getCharacterList() async {
    var box = Hive.box<String>("StoreCharacterResponse");
    String? data = box.get("characters");
    print(data);
    if (data == null) return [];
    List decoded = jsonDecode(data);
    return decoded.map((e) => RickAndMortyApiAllResponseResults.fromJson(e)).toList();
  }

  static Future<void> deleteCharacterList() async {
    var box = Hive.box<String>("StoreCharacterResponse");
    await box.delete("characters");
  }


  static Future<void> updateCharacter({
    required int id,
    String? name,
    String? status,
  }) async {
    var box = Hive.box<String>("StoreCharacterResponse");
    String? data = box.get("characters");
    if (data == null) return;

    List decoded = jsonDecode(data);

    List<RickAndMortyApiAllResponseResults> list = decoded
        .map((e) => RickAndMortyApiAllResponseResults.fromJson(e))
        .toList();

    int index = list.indexWhere((e) => e.id == id);

    if (index != -1) {

      var item = list[index];
      if (name != null) item.name = name;
      if (status != null) item.status = status;
      list.removeAt(index);
      list.insert(0, item);
    }

    await box.put("characters", jsonEncode(list.map((e) => e.toJson()).toList()),);
  }

}