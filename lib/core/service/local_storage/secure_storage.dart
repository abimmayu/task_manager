import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class SecureStorage {
  Future<String?> read(String key) async => await storage.read(key: key);
  Future<void> write(String key, String value) async => await storage.write(
        key: key,
        value: value,
      );
  Future<void> delete(String key) async => await storage.delete(key: key);
}
