import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catatan_polnes/main.dart';

void main() {
  testWidgets('Aplikasi dapat dimuat tanpa crash', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AplikasiCatatan()));
    expect(find.byType(AplikasiCatatan), findsOneWidget);
  });
}
