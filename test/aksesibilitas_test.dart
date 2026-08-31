import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catatan_polnes/presentation/layar/layar_beranda.dart';
import 'package:catatan_polnes/presentation/theme/app_theme.dart';

void main() {
  testWidgets('layar beranda memenuhi pedoman aksesibilitas', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.terang(),
          home: const LayarBeranda(),
        ),
      ),
    );

    // Menyelesaikan timer delay 1 detik pada AsyncNotifier
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(textContrastGuideline));
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}