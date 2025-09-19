import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../coupons/application/get_coupons_provider.dart' show loyaltyPointsProvider, myCouponsProvider;
import '../../feed/application/feed_providers.dart' show myReviewsProvider;
import 'package:chefscore/features/dashboards/application/dashboards_providers.dart' show kpisProvider, topProductsProvider;

import '../domain/product.dart';
import '../domain/branch.dart';
import '../domain/new_review.dart';
import '../application/create_review_controller.dart';

class ReviewFormScreen extends ConsumerStatefulWidget {
  const ReviewFormScreen({super.key, required this.product, required this.branch});

  final Product product;
  final Branch branch;

  @override
  ConsumerState<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends ConsumerState<ReviewFormScreen> {
  int _productStars = 5;
  int _serviceStars = 5;
  final _commentCtrl = TextEditingController();

  bool _submitting = false;
  double _starsScale = 1.0;
  int _starsAnimKey = 0; // forces AnimatedSwitcher transitions

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(createReviewControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        centerTitle: false,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(widget.branch.name, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text('Tu experiencia', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),

                // Producto
                Text('Producto', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                AnimatedScale(
                  scale: _starsScale,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    child: KeyedSubtree(
                      key: ValueKey(_starsAnimKey * 10 + _productStars),
                      child: _StarsPicker(
                        value: _productStars,
                        size: 40,
                        onChanged: (v) async {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _productStars = v;
                            _starsScale = 1.08;
                            _starsAnimKey++;
                          });
                          await Future.delayed(const Duration(milliseconds: 120));
                          if (mounted) setState(() => _starsScale = 1.0);
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text('Servicio', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                AnimatedScale(
                  scale: _starsScale,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    child: KeyedSubtree(
                      key: ValueKey(_starsAnimKey * 20 + _serviceStars),
                      child: _StarsPicker(
                        value: _serviceStars,
                        size: 40,
                        onChanged: (v) async {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _serviceStars = v;
                            _starsScale = 1.08;
                            _starsAnimKey++;
                          });
                          await Future.delayed(const Duration(milliseconds: 120));
                          if (mounted) setState(() => _starsScale = 1.0);
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                TextField(
                  controller: _commentCtrl,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Comentario (opcional)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 28),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _submitting
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () async {
                              if (_submitting) return;
                              setState(() => _submitting = true);
                              HapticFeedback.lightImpact();
                              final review = NewReview(
                                productId: widget.product.id,
                                branchId: widget.branch.id,
                                productStars: _productStars,
                                serviceStars: _serviceStars,
                                comment: _commentCtrl.text.trim(),
                              );
                              await ref.read(createReviewControllerProvider.notifier).submit(review);

                              // Invalida/actualiza providers clave: dashboard KPIs, puntos, cupones y tus comentarios
                              ref.invalidate(kpisProvider);
                              ref.invalidate(topProductsProvider);
                              ref.invalidate(loyaltyPointsProvider);
                              ref.invalidate(myCouponsProvider);
                              ref.invalidate(myReviewsProvider);

                              if (!mounted) return;
                              await _showSuccessSheet();
                            },
                            child: const Text('Enviar reseña'),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSuccessSheet() async {
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                child: const Icon(Icons.check_circle, size: 72),
              ),
              const SizedBox(height: 12),
              const Text('¡Reseña enviada!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('Gracias por tu aporte', textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst); // vuelve al dashboard/root
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }
}

class _StarsPicker extends StatelessWidget {
  const _StarsPicker({required this.value, required this.onChanged, this.size = 30});
  final int value;
  final ValueChanged<int> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final idx = i + 1;
        final filled = idx <= value;
        return IconButton(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          iconSize: size,
          icon: Icon(filled ? Icons.star : Icons.star_border),
          onPressed: () => onChanged(idx),
        );
      }),
    );
  }
}