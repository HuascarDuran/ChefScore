

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/product.dart';
import '../domain/branch.dart';
import '../../review/application/catalog_providers.dart';

/// Pantalla para escoger la sucursal a partir de un [Product].
///
/// Importante: en el router, pásale el `product` desde `state.extra`:
/// ```dart
/// pageBuilder: (context, state) => NoTransitionPage(
///   child: BranchPickerScreen(product: state.extra as Product),
/// ),
/// ```
class BranchPickerScreen extends ConsumerWidget {
  const BranchPickerScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesAsync = ref.watch(activeCitiesProvider);
    final branchesAsync = ref.watch(activeBranchesProvider);
    final selectedCity = ref.watch(selectedCityProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Elige sucursal — ${product.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro por ciudad
            Row(
              children: [
                const Icon(Icons.location_city, color: Colors.blueAccent),
                const SizedBox(width: 8),
                const Text(
                  'Ciudad:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: citiesAsync.when(
                    data: (cities) {
                      final items = <DropdownMenuItem<String?>>[
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Todas'),
                        ),
                        ...cities.map(
                          (c) => DropdownMenuItem<String?>(
                            value: c,
                            child: Text(c),
                          ),
                        ),
                      ];
                      return DropdownButtonFormField<String?>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        value: selectedCity,
                        items: items,
                        onChanged: (value) {
                          ref.read(selectedCityProvider.notifier).state = value;
                          ref.invalidate(activeBranchesProvider);
                        },
                      );
                    },
                    error: (e, _) => Text('Error cargando ciudades: $e'),
                    loading: () => const LinearProgressIndicator(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: branchesAsync.when(
                data: (branches) {
                  if (branches.isEmpty) {
                    return const Center(
                      child: Text('No hay sucursales disponibles.'),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(activeBranchesProvider);
                    },
                    child: ListView.separated(
                      itemCount: branches.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final Branch b = branches[index];
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              'newReviewForm',
                              extra: {
                                'product': product,
                                'branch': b,
                              },
                            );
                          },
                          child: Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    b.name,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  if (b.city.isNotEmpty)
                                    Text(
                                      b.city,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (e, _) => Center(child: Text('Error: $e')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}