import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/product.dart';
import '../domain/branch.dart';

/// Repositorio de catálogo (productos del menú y sucursales activas)
class CatalogRepo {
  final SupabaseClient client;
  CatalogRepo(this.client);

  /// Lista de productos del menú. Puedes filtrar por [search].
  Future<List<Product>> menuProducts({String? search}) async {
    final data = await client
        .from('products')
        .select('id, name, image_path')
        .order('name');

    var list = (data as List)
        .map((row) => Product.fromMap(Map<String, dynamic>.from(row)))
        .toList();

    if (search != null && search.trim().isNotEmpty) {
      final q = search.trim().toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  /// Lista de sucursales activas. Puedes filtrar por [city].
  Future<List<Branch>> activeBranches({String? city}) async {
    var query = client
        .from('branches')
        .select('id, name, city, is_active')
        .eq('is_active', true);

    if (city != null && city.trim().isNotEmpty) {
      query = query.eq('city', city.trim());
    }

    final data = await query.order('name');
    final list = (data as List)
        .map((row) => Branch.fromMap(Map<String, dynamic>.from(row)))
        .toList();
    return list;
  }

  /// (Opcional) Lista de ciudades con sucursales activas, para filtros.
  Future<List<String>> activeCities() async {
    final data = await client
        .from('branches')
        .select('city')
        .eq('is_active', true)
        .order('city');

    final set = <String>{};
    for (final row in (data as List)) {
      final city = (row as Map<String, dynamic>)['city'] as String?;
      if (city != null && city.trim().isNotEmpty) set.add(city.trim());
    }
    return set.toList();
  }
}