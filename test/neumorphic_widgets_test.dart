import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neumorphism_widgets/neumorphics.dart';

void main() {
  testWidgets('NeuButton test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NeuButton(
          onPressed: (isTap) {},
          boxShadowColor: Colors.black,
          child: const Text('NeuButton'),
        ),
      ),
    ));

    // Verify that NeuButton is shown
    expect(find.byType(NeuButton), findsOneWidget);
  });

  testWidgets('NeuCheckbox test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: NeuCheckbox(
          isChecked: false,
          activeColor: Colors.green,
          enable: true,
          boxShadowColor: Colors.black,
        ),
      ),
    ));

    // Verify that NeuCheckbox is shown
    expect(find.byType(NeuCheckbox), findsOneWidget);
  });

  testWidgets('NeuContainer test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: NeuContainer(
          boxShadowColor: Colors.black,
          child: Text('NeuContainer Child'),
        ),
      ),
    ));

    // Verify that NeuContainer is shown
    expect(find.byType(NeuContainer), findsOneWidget);

    // Verify that the child Text widget is shown
    expect(find.text('NeuContainer Child'), findsOneWidget);
  });

  testWidgets('NeuSwitch test', (WidgetTester tester) async {
    bool switchValue = false;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NeuSwitch(
          boxShadowColor: Colors.black,
          onChanged: (value) {
            switchValue = value;
          },
          value: switchValue,
        ),
      ),
    ));

    // Verify that NeuSwitch is shown
    expect(find.byType(NeuSwitch), findsOneWidget);

    // Tap the switch
    await tester.tap(find.byType(NeuSwitch));
    await tester.pumpAndSettle();

    // Verify that the switch value has changed
    expect(switchValue, isTrue);
  });
  testWidgets('NeuAppBar test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: NeuAppBar(
          boxShadowColor: Colors.black,
          title: const Text('NeuAppBar Title'),
          isScrolled: ValueNotifier<bool>(false),
        ),
        body: Container(),
      ),
    ));

    // Verify that NeuAppBar is shown
    expect(find.byType(NeuAppBar), findsOneWidget);

    // Verify that the title Text widget is shown
    expect(find.text('NeuAppBar Title'), findsOneWidget);
  });

  testWidgets('NeuSlider test', (WidgetTester tester) async {
    double sliderValue = 50;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NeuSlider(
          boxShadowColor: Colors.black,
          onChanged: (value) {
            sliderValue = value;
          },
          value: sliderValue,
          enabled: true, // Ensure that the NeuSlider is enabled
        ),
      ),
    ));

    // Verify that NeuSlider is shown
    expect(find.byType(NeuSlider), findsOneWidget);

    // Simulate a drag event on the slider
    final Offset center = tester.getCenter(find.byType(NeuSlider));
    final TestGesture gesture = await tester.startGesture(center);
    await gesture.moveBy(const Offset(50, 0));
    await tester.pumpAndSettle();

    // Verify that the slider value has changed
    expect(sliderValue, isNot(0));
  });
}
