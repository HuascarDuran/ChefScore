import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class RewardsPage extends ConsumerWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(pointsProvider);
    final discountsAsync = ref.watch(discountCodesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards & Descuentos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            pointsAsync.when(
              data: (p) => ListTile(
                leading: const Icon(Icons.stars),
                title: const Text('Puntos'),
                subtitle: Text('$p'),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Codigos de descuento', style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: discountsAsync.when(
                data: (codes) => codes.isEmpty
                    ? const Center(child: Text('Aún no tienes códigos.'))
                    : ListView.separated(
                        itemCount: codes.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) => ListTile(
                          leading: const Icon(Icons.qr_code),
                          title: Text(codes[i]),
                          trailing: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Código copiado (simulado)')),
                              );
                            },
                          ),
                        ),
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () async {
                try {
                  // Ejemplo de canje: 50 puntos por souvenir (solo para demo)
                  await ref.read(rewardServiceProvider).redeem(50);
                  ref.invalidate(pointsProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Canje exitoso (demo)')),
                    );
                  }
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Canjear 50 pts (demo)'),
            ),
          ],
        ),
      ),
    );
  }
}
