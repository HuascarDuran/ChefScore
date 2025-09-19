import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceId {
  static const _key = 'device_id';

  static Future<String> get() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_key);
    if (id != null) return id;

    id = const Uuid().v4();
    await prefs.setString(_key, id);
    return id;
  }
}

/// Provider que expone el device ID como FutureProvider
final deviceIdProvider = FutureProvider<String>((ref) async {
  return await DeviceId.get();
});