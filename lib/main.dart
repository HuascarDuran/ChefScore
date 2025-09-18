import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'core/router.dart';
import 'core/db/seed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbSeeder.run();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Reviews',
      theme: appTheme(),
      routes: AppRouter.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
