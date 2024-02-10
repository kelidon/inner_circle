import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    ThemeData buildTheme() {
      var baseTheme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );

      return baseTheme.copyWith(
        textTheme: GoogleFonts.kanitTextTheme(baseTheme.textTheme),
      );
    }

    return MaterialApp(
      title: 'inner circle',
      theme: buildTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
