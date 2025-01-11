// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:carex_pro/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CareXProApp());

    // Verify that Login slogan widget available.
    expect(find.text('An AI Health Consultant'), findsWidgets);

    // // Tap the login button and trigger a frame.
    // await tester.tap(find.byWidget(Text("Login")));
    // await tester.pump();

    // // Verify that Profile widget available
    // expect(find.text('Your health is our priority'), findsWidgets);
  });
}
