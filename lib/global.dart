import 'package:spotify_search/storage_service.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    storageService = StorageService().init();
    }
}