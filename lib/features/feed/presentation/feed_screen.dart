import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/feed_providers.dart';
import 'widgets/review_tile.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(myReviewsProvider);
    final refresh = ref.watch(refreshMyReviewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            onPressed: refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: reviewsAsync.when(
          data: (reviews) {
            if (reviews.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: const [_EmptyState()],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) => ReviewTile(review: reviews[i]),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: reviews.length,
            );
          },
          loading: () => ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _Shimmer(),
              SizedBox(height: 12),
              _Shimmer(),
              SizedBox(height: 12),
              _Shimmer(),
            ],
          ),
          error: (e, _) => ListView(
            padding: const EdgeInsets.all(16),
            children: const [ _ErrorBox(msg: 'No se pudieron cargar tus comentarios') ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Aún no has hecho comentarios', style: theme.titleMedium),
            const SizedBox(height: 8),
            const Text(
              'Escribe reseñas sobre los productos que pruebas para ayudar a otros '
              'usuarios y empezar a acumular puntos.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(height: 110, child: Center(child: CircularProgressIndicator())),
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