import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import 'core/app.dart';
import 'core/env/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  final storage = FlutterSecureStorage();
  final deviceId = await storage.read(key: 'device_id') ?? const Uuid().v4();
  await storage.write(key: 'device_id', value: deviceId);

  runApp(const ProviderScope(child: App()));
}
