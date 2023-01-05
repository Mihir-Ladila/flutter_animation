import 'package:flutter_test/flutter_test.dart';
import 'package:widget_to_photo/main.dart';
import 'package:flutter/material.dart';

void main() {
  test('add', () {
    var answer = 42;
    expect(answer, 40 + 2);
  });

  testWidgets('widget Test', (WidgetTester test) async {
    final app = MyApp();
    await test.pumpWidget(app);
    expect(find.text('0'), findsOneWidget);
    await test.tap(find.byIcon(Icons.add));
    await test.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
