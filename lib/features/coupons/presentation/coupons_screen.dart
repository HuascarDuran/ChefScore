import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/get_coupons_provider.dart';
import '../domain/coupon_model.dart';

class CouponsScreen extends ConsumerWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(loyaltyPointsProvider);
    final couponsAsync = ref.watch(myCouponsProvider);
    final refresh = ref.watch(refreshCouponsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            pointsAsync.when(
              data: (sum) => _PointsCard(points: sum.points),
              loading: () => const _Shimmer(height: 72),
              error: (e, _) => _ErrorBox(msg: 'No se pudieron cargar tus puntos'),
            ),
            const SizedBox(height: 16),
            couponsAsync.when(
              data: (list) => list.isEmpty
                  ? _EmptyState(pointsAsync.asData?.value.points ?? 0)
                  : _CouponsList(coupons: list),
              loading: () => Column(
                children: const [
                  _Shimmer(height: 120),
                  SizedBox(height: 12),
                  _Shimmer(height: 120),
                ],
              ),
              error: (e, _) => _ErrorBox(msg: 'No se pudieron cargar tus cupones'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PointsCard extends StatelessWidget {
  const _PointsCard({required this.points});
  final int points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.stars, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tus puntos', style: theme.titleMedium),
                  const SizedBox(height: 4),
                  Text('$points', style: theme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CouponsList extends StatelessWidget {
  const _CouponsList({required this.coupons});
  final List<Coupon> coupons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: coupons.map((c) => _CouponTile(coupon: c)).toList(),
    );
  }
}

class _CouponTile extends StatelessWidget {
  const _CouponTile({required this.coupon});
  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final exp = coupon.expiresAt;
    final expires =
        exp == null ? 'Sin fecha de expiración' : 'Vence: ${_fmt(exp)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${coupon.percentOff}% de descuento', style: theme.titleMedium),
            const SizedBox(height: 4),
            Text(expires, style: theme.bodySmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SelectableText(
                    coupon.code,
                    style: theme.titleLarge?.copyWith(letterSpacing: 1.2, fontFeatures: const []),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copiar'),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: coupon.code));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Código copiado')),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) {
    // ISO corto local
    final local = d.toLocal();
    final yyyy = local.year.toString().padLeft(4, '0');
    final mm = local.month.toString().padLeft(2, '0');
    final dd = local.day.toString().padLeft(2, '0');
    return '$yyyy-$mm-$dd';
    // Si usas intl, puedes reemplazar por DateFormat('dd/MM/yyyy').format(local)
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState(this.points);
  final int points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final hasPoints = points > 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('No tienes cupones disponibles', style: theme.titleMedium),
            const SizedBox(height: 8),
            Text(
              hasPoints
                  ? 'Sigue acumulando puntos para canjear un cupón de descuento.'
                  : 'Aún no tienes puntos. Crea reseñas para ganar puntos y obtener códigos de descuento.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(msg),
      ),
    );
  }
}