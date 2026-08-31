import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';
import 'package:catatan_polnes/presentation/widget/kartu_catatan.dart';
import 'package:catatan_polnes/presentation/theme/app_theme.dart';

void main() {
  final sampleCatatan = Catatan.baru(
    judul: 'Catatan Testing Golden',
    isi: 'Ini adalah isi catatan untuk uji tampilan visual.',
  );

  testWidgets('Golden Test - KartuCatatan Mode Terang & Gelap', (tester) async {
    // Set ukuran layar testing agar konsisten
    await tester.binding.setSurfaceSize(const Size(400, 200));

    // 1. Tampilan Mode Terang
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.terang(),
        home: Scaffold(
          body: Center(
            child: KartuCatatan(
              catatan: sampleCatatan,
              onKetuk: () {},
              onHapus: () {}, // 📍 Menambahkan parameter wajib onHapus
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verifikasi visual Mode Terang
    await expectLater(
      find.byType(KartuCatatan),
      matchesGoldenFile('goldens/kartu_catatan_terang.png'),
    );

    // 2. Tampilan Mode Gelap
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.gelap(),
        home: Scaffold(
          body: Center(
            child: KartuCatatan(
              catatan: sampleCatatan,
              onKetuk: () {},
              onHapus: () {}, // 📍 Menambahkan parameter wajib onHapus
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verifikasi visual Mode Gelap
    await expectLater(
      find.byType(KartuCatatan),
      matchesGoldenFile('goldens/kartu_catatan_gelap.png'),
    );
  });
}