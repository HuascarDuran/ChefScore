

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;
}



final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return SupabaseService.client;
});