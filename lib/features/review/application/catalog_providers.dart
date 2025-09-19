import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/supabase_client.dart';
import '../domain/product.dart';
import '../domain/branch.dart';
import '../infrastructure/catalog_repo.dart';

/// Repo provider
final catalogRepoProvider = Provider<CatalogRepo>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return CatalogRepo(client);
});

/// --- UI state: filtros de catálogo ---
/// Texto de búsqueda para productos (nullable cuando está vacío)
final productSearchProvider = StateProvider<String>((ref) => '');

/// Ciudad seleccionada para filtrar sucursales (null = todas)
final selectedCityProvider = StateProvider<String?>((ref) => null);

/// --- Datos: productos del menú ---
final menuProductsProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final repo = ref.watch(catalogRepoProvider);
  final search = ref.watch(productSearchProvider);
  final term = search.trim();
  return repo.menuProducts(search: term.isEmpty ? null : term);
});

/// --- Datos: sucursales activas (opcionalmente por ciudad) ---
final activeBranchesProvider = FutureProvider.autoDispose<List<Branch>>((ref) async {
  final repo = ref.watch(catalogRepoProvider);
  final city = ref.watch(selectedCityProvider);
  final c = (city != null && city.trim().isNotEmpty) ? city.trim() : null;
  return repo.activeBranches(city: c);
});

/// --- Datos: lista de ciudades con sucursales activas ---
final activeCitiesProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final repo = ref.watch(catalogRepoProvider);
  return repo.activeCities();
});

/// --- Alias de compatibilidad ---
/// Algunas pantallas referencian `catalogProductsProvider`.
/// Lo mapeamos a `menuProductsProvider` para mantener compatibilidad.
final catalogProductsProvider = menuProductsProvider;
