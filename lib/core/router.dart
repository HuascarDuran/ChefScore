

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/app_scaffold.dart';

import '../features/dashboards/presentation/dashboards_screen.dart';
import '../features/feed/presentation/feed_screen.dart';
import '../features/review/presentation/start_review_screen.dart';
import '../features/review/presentation/branch_picker_screen.dart';
import '../features/review/presentation/review_form_screen.dart';
import '../features/review/presentation/my_reviews_screen.dart';
import '../features/coupons/presentation/coupons_screen.dart';
import '../features/review/domain/product.dart';
import '../features/review/domain/branch.dart';

/// Rutas de la app
const dashboardsRoute = '/';
const feedRoute = '/feed';
const reviewRoute = '/review';
const couponsRoute = '/coupons';


/// GoRouter expuesto vía Riverpod
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: dashboardsRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final loc = state.matchedLocation;
          int currentIndex;
          if (loc == dashboardsRoute) {
            currentIndex = 0;
          } else if (loc.startsWith(feedRoute)) {
            currentIndex = 0;
          } else if (loc.startsWith(reviewRoute)) {
            currentIndex = 2;
          } else if (loc.startsWith(couponsRoute)) {
            currentIndex = 3;
          } else {
            currentIndex = 0;
          }

          return AppScaffold(
            child: child,
            currentIndex: currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go(dashboardsRoute);
                  break;
                case 1:
                  context.go(feedRoute);
                  break;
                case 2:
                  context.go(reviewRoute);
                  break;
                case 3:
                  context.go(couponsRoute);
                  break;
              }
            },
          );
        },
        routes: [
          GoRoute(
            path: dashboardsRoute,
            name: 'dashboards',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const DashboardsScreen()),
          ),
          GoRoute(
            path: feedRoute,
            name: 'feed',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const FeedScreen()),
          ),
          GoRoute(
            path: reviewRoute,
            name: 'review',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const StartReviewScreen()),
            routes: [
              GoRoute(
                path: 'branch-picker',
                name: 'branchPicker',
                pageBuilder: (context, state) {
                  final product = state.extra as Product;
                  return NoTransitionPage(child: BranchPickerScreen(product: product));
                },
              ),
              GoRoute(
                path: 'form',
                name: 'newReviewForm',
                pageBuilder: (context, state) {
                  final args = state.extra as Map<String, Object?>;
                  final product = args['product'] as Product;
                  final branch  = args['branch']  as Branch;
                  return NoTransitionPage(child: ReviewFormScreen(product: product, branch: branch));
                },
              ),
              GoRoute(
                path: 'mine',
                name: 'myReviews',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const MyReviewsScreen()),
              ),
            ],
          ),
          GoRoute(
            path: couponsRoute,
            name: 'coupons',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const CouponsScreen()),
          ),
        ],
      ),
    ],
  );
});