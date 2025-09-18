import 'package:flutter/material.dart';
import '../features/orders/presentation/orders_page.dart';
import '../features/reviews/presentation/reviews_page.dart';
import '../features/rewards/presentation/rewards_page.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => const OrdersPage(),
    '/reviews': (_) => const ReviewsPage(),
    '/rewards': (_) => const RewardsPage(),
  };
}
