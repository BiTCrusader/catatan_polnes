import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catatan_polnes/presentation/layar/layar_beranda.dart';

void main() {
  testWidgets('Aplikasi dapat dimuat tanpa crash', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LayarBeranda(),
        ),
      ),
    );

    // Menyelesaikan timer delay 1 detik
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.byType(LayarBeranda), findsOneWidget);
  });
}