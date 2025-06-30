// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rentalyze/main.dart';

void main() {
  testWidgets('Rentalyze property management app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: RentalyzeApp()));

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that our app shows the dashboard with portfolio data
    expect(find.text('Portfolio Dashboard'), findsOneWidget);
    expect(find.text('Total Properties'), findsOneWidget);
    expect(find.text('Portfolio Value'), findsOneWidget);
    expect(find.text('Recent Properties'), findsOneWidget);
    
    // Verify bottom navigation is present
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Properties'), findsOneWidget);
    expect(find.text('Financial'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
