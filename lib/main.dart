import 'package:flutter/material.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:inner_circle/common/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inner circle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
