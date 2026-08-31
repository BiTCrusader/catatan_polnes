import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: AplikasiCatatan()));
}

class AplikasiCatatan extends StatelessWidget {
  const AplikasiCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Catatan POLNES',
      debugShowCheckedModeBanner: false,
      // 📍 Tema Material 3 (Terang & Gelap otomatis mengikuti sistem HP)
      theme: AppTheme.terang(),
      darkTheme: AppTheme.gelap(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      // 📍 Langkah 8c: Pembungkus Aksesibilitas (Membatasi Skala Teks Ekstrem)
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: 1.0,
              maxScaleFactor: 1.8,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
