import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage/local_storage.dart';

final localStorageProvider = Provider<LocalStorage>((ref) => SharedPrefsStorage());
