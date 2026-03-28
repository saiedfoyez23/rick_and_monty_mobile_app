import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';

class HiveInitialization {
  static Future<void> hiveInitialization() async {
    final localPath = await path.getDownloadsDirectory();
    Hive.init(localPath?.path);
    await Hive.openBox<String>("StoreCharacterResponse");
  }
}
