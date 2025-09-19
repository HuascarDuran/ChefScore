import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(createReviewControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Valorar ${widget.product.name}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.branch.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('¿Qué te pareció el producto?', style: Theme.of(context).textTheme.labelLarge),
              _StarsPicker(
                value: _productStars,
                onChanged: (v) => setState(() => _productStars = v),
              ),
              const SizedBox(height: 16),
              Text('¿Qué te pareció el servicio?', style: Theme.of(context).textTheme.labelLarge),
              _StarsPicker(
                value: _serviceStars,
                onChanged: (v) => setState(() => _serviceStars = v),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _commentCtrl,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Comentario (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitState.isLoading
                      ? null
                      : () async {
                          final review = NewReview(
                            productId: widget.product.id,
                            branchId: widget.branch.id,
                            productStars: _productStars,
                            serviceStars: _serviceStars,
                            comment: _commentCtrl.text.trim(),
                          );
                          await ref
                              .read(createReviewControllerProvider.notifier)
                              .submit(review);
                          if (mounted) Navigator.of(context).pop();
                        },
                  child: submitState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Enviar reseña'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarsPicker extends StatelessWidget {
  const _StarsPicker({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        final idx = i + 1;
        final filled = idx <= value;
        return IconButton(
          icon: Icon(filled ? Icons.star : Icons.star_border),
          onPressed: () => onChanged(idx),
        );
      }),
    );
  }
}