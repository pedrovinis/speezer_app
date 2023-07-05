// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:speezer_app/main.dart';

void main() async {
  testWidgets('Play music test', (WidgetTester tester) async {
    await tester.pumpWidget(const SpeezerApp());

    //Verify that the player state is reseted and being rendered
    expect(find.text("0:00"), findsWidgets);

    //Verify if all control buttons are being rendered
    expect(find.byIcon(Icons.skip_next), findsOneWidget);
    expect(find.byIcon(Icons.skip_previous), findsOneWidget);

    //Find and play icon and start repdroducing
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    await tester.tap(find.byIcon(Icons.play_arrow));

    //Verify if music is running by icon
    sleep(const Duration(seconds: 1));
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });
}
