import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import 'new_order_sheet.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.reviews),
            onPressed: () => Navigator.pushNamed(context, '/reviews'),
            tooltip: 'Reseñas',
          ),
          IconButton(
            icon: const Icon(Icons.card_giftcard),
            onPressed: () => Navigator.pushNamed(context, '/rewards'),
            tooltip: 'Rewards',
          ),
        ],
      ),
      body: ordersAsync.when(
        data: (orders) => orders.isEmpty
            ? const Center(child: Text('Sin pedidos todavía'))
            : ListView.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final o = orders[i];
                  final eligible = ref.read(orderServiceProvider).eligibleForDiscount(o);
                  return ListTile(
                    title: Text(o.items.join(' · ')),
                    subtitle: Text('${o.createdAt} • ${o.reviewed ? "Reseñado" : "Pendiente de reseña"}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (eligible) const Text('Descuento disponible', style: TextStyle(fontSize: 12)),
                        if (o.reviewed) const Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final items = await showModalBottomSheet<List<String>>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const SafeArea(child: NewOrderSheet()),
          );
          if (items == null || items.isEmpty) return;
          await ref.read(orderServiceProvider).createOrder(items: items);
          ref.invalidate(ordersListProvider);
        },
        label: const Text('Nuevo pedido'),
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
