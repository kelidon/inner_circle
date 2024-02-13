import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

const appName = 'inner circle';

class ICAppBarTitle extends StatelessWidget {
  const ICAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GlowText(
      appName,
      style: GoogleFonts.orbitron(
        color: AppColors.schemeSeedLight,
        fontSize: 25,
      ),
      glowColor: AppColors.schemeSeedLight,
      blurRadius: 20,
    );
  }
}
