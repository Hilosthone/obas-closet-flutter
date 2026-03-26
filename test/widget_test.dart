import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:obas_closet/main.dart';

void main() {
  testWidgets('OBA’S Closet Home Screen Smoke Test', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame.
    // We use ObasClosetApp because that is the class name in your main.dart
    await tester.pumpWidget(const ObasClosetApp());

    // 2. Verify that the Brand Name is visible in the AppBar
    expect(find.text("OBA’S CLOSET"), findsOneWidget);

    // 3. Verify that the Search Bar exists
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Search vintage shirts, gowns..."), findsOneWidget);

    // 4. Verify that the Category list is present (checking for 'All')
    expect(find.text("All"), findsOneWidget);

    // 5. Verify that the Location Banner is showing
    expect(find.text("Ilorin | Nationwide Delivery"), findsOneWidget);
  });
}