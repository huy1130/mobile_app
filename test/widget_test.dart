import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart';

void main() {
  FlutterSecureStorage.setMockInitialValues({});

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthcarePatientApp());
    // Advance time past the 1.2s splash delay
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
    expect(find.byType(HealthcarePatientApp), findsOneWidget);
  });
}
