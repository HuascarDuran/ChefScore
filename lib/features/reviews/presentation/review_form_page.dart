import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class ReviewFormPage extends ConsumerStatefulWidget {
  final String orderId;
  const ReviewFormPage({super.key, required this.orderId});

  @override
  ConsumerState<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends ConsumerState<ReviewFormPage> {
  int product = 5;
  int service = 5;
  final ctrl = TextEditingController();

  Widget _stars(int current, void Function(int) onTap) {
    return Row(
      children: List.generate(5, (i) {
        final idx = i + 1;
        return IconButton(
          onPressed: () => onTap(idx),
          icon: Icon(idx <= current ? Icons.star : Icons.star_border),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rs = ref.read(reviewServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva reseña')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: Text('Producto')),
            _stars(product, (v) => setState(() => product = v)),
            const Align(alignment: Alignment.centerLeft, child: Text('Atención/Servicio')),
            _stars(service, (v) => setState(() => service = v)),
            const SizedBox(height: 8),
            TextField(
              controller: ctrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Comentario (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Enviar reseña'),
              onPressed: () async {
                try {
                  await rs.submitReview(
                    orderId: widget.orderId,
                    productStars: product,
                    serviceStars: service,
                    comment: ctrl.text.isEmpty ? null : ctrl.text,
                  );
                  if (mounted) Navigator.pop(context, true);
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
