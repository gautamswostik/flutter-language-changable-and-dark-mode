import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_adapter.dart';

class HiveSetup {
  HiveSetup._();

  static Future initHive() async {
    try {
      final dbPath = await databasePath;
      Hive.init(dbPath);
      HiveAdapter.init();
    } catch (e) {
      log('Hive init exception : $e');
    }
  }
}

const String _dbDirectory = 'mylanguageandtheme';

///
Future<String> get databasePath async {
  final appDir = await getApplicationDocumentsDirectory();
  final databaseDir = Directory('${appDir.path}/$_dbDirectory');
  return databaseDir.path;
}
