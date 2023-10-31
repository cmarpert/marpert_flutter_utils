import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marpert_flutter_utils/marpert_flutter_utils.dart';

void main() {
  testWidgets('HighlightText widget test - one match', (WidgetTester tester) async {
    /// arrange

    const tText = 'This is some text';
    const tTextToHighlight = 'some';
    const tHighlightTextColor = Colors.red;
    const tHighlightBackgroundColor = Colors.yellow;
    const tStyle = TextStyle(color: Colors.white, backgroundColor: Colors.black);
    const expectedNumberOfTextSpans = 3;
    const expectedTextSpan = ['This is ', 'some', ' text'];
    const expectedTextSpanHighlighted = [
      false,
      true,
      false,
    ];

    late final Widget sut;

    sut = const HighlightText(
      text: tText,
      textToHighlight: tTextToHighlight,
      highlightTextColor: tHighlightTextColor,
      highlightBackgroundColor: tHighlightBackgroundColor,
      style: tStyle,
    );

    /// act

    // Pump the widget tree to render the HighlightText widget.
    await tester.pumpWidget(MaterialApp(home: sut));
    debugDumpApp();

    ///assert
    // Find the HighlightText widget in the widget tree.
    final richTextFinder = find.byKey(const Key('HighlightedText'));
    expect(richTextFinder, findsOneWidget);

    // Access the RichText-Widget
    final richTextWidget = tester.widget<RichText>(richTextFinder);

    // Access the TextSpan elements
    final textSpans = (richTextWidget.text as TextSpan).children;

    // Verify total number of TextSpans
    expect(textSpans?.length, equals(expectedNumberOfTextSpans));

    textSpans?.forEachIndexed((index, textSpan) {
      expect(textSpan.toPlainText(), equals(expectedTextSpan[index]));
      expect(textSpan.style?.color,
          equals(expectedTextSpanHighlighted[index] ? tHighlightTextColor : tStyle.color));
      expect(textSpan.style?.backgroundColor,
          equals(expectedTextSpanHighlighted[index] ? tHighlightBackgroundColor : tStyle.backgroundColor));
    });
  });

  testWidgets('HighlightText widget test - multiple matches', (WidgetTester tester) async {
    /// arrange

    const tText = 'This is some text';
    const tTextToHighlight = 's';
    const tHighlightTextColor = Colors.red;
    const tHighlightBackgroundColor = Colors.yellow;
    const tStyle = TextStyle(color: Colors.white, backgroundColor: Colors.black);
    const expectedNumberOfTextSpans = 7;
    const expectedTextSpan = ['Thi', 's', ' i', 's', ' ', 's', 'ome text'];
    const expectedTextSpanHighlighted = [false, true, false, true, false, true, false, true, false];

    late final Widget sut;

    sut = const HighlightText(
      text: tText,
      textToHighlight: tTextToHighlight,
      highlightTextColor: tHighlightTextColor,
      highlightBackgroundColor: tHighlightBackgroundColor,
      style: tStyle,
    );

    /// act

    // Pump the widget tree to render the HighlightText widget.
    await tester.pumpWidget(MaterialApp(home: sut));

    ///assert
    // Find the HighlightText widget in the widget tree.
    final richTextFinder = find.byKey(const Key('HighlightedText'));
    expect(richTextFinder, findsOneWidget);

    // Access the RichText-Widget
    final richTextWidget = tester.widget<RichText>(richTextFinder);

    // Access the TextSpan elements
    final textSpans = (richTextWidget.text as TextSpan).children;

    // Verify total number of TextSpans
    expect(textSpans?.length, equals(expectedNumberOfTextSpans));

    textSpans?.forEachIndexed((index, textSpan) {
      expect(textSpan.toPlainText(), equals(expectedTextSpan[index]));
      expect(textSpan.style?.color,
          equals(expectedTextSpanHighlighted[index] ? tHighlightTextColor : tStyle.color));
      expect(textSpan.style?.backgroundColor,
          equals(expectedTextSpanHighlighted[index] ? tHighlightBackgroundColor : tStyle.backgroundColor));
    });
  });

  testWidgets('HighlightText widget test - no match', (WidgetTester tester) async {
    /// arrange

    const tText = 'This is some text';
    const tTextToHighlight = 'nothing';
    const tHighlightTextColor = Colors.red;
    const tHighlightBackgroundColor = Colors.yellow;
    const tStyle = TextStyle(color: Colors.white, backgroundColor: Colors.black);
    const expectedNumberOfTextSpans = 1;
    const expectedTextSpan = ['This is some text'];
    const expectedTextSpanHighlighted = [false];

    late final Widget sut;

    sut = const HighlightText(
      text: tText,
      textToHighlight: tTextToHighlight,
      highlightTextColor: tHighlightTextColor,
      highlightBackgroundColor: tHighlightBackgroundColor,
      style: tStyle,
    );

    /// act

    // Pump the widget tree to render the HighlightText widget.
    await tester.pumpWidget(MaterialApp(home: sut));

    ///assert
    // Find the HighlightText widget in the widget tree.
    final richTextFinder = find.byKey(const Key('HighlightedText'));
    expect(richTextFinder, findsOneWidget);

    // Access the RichText-Widget
    final richTextWidget = tester.widget<RichText>(richTextFinder);

    // Access the TextSpan elements
    final textSpans = (richTextWidget.text as TextSpan).children;

    // Verify total number of TextSpans
    expect(textSpans?.length, equals(expectedNumberOfTextSpans));

    textSpans?.forEachIndexed((index, textSpan) {
      expect(textSpan.toPlainText(), equals(expectedTextSpan[index]));
      expect(textSpan.style?.color,
          equals(expectedTextSpanHighlighted[index] ? tHighlightTextColor : tStyle.color));
      expect(textSpan.style?.backgroundColor,
          equals(expectedTextSpanHighlighted[index] ? tHighlightBackgroundColor : tStyle.backgroundColor));
    });
  });

  testWidgets('HighlightText widget test - textToHighlight is Empty', (WidgetTester tester) async {
    /// arrange

    const tText = 'This is some text';
    const tTextToHighlight = '';
    const tHighlightTextColor = Colors.red;
    const tHighlightBackgroundColor = Colors.yellow;
    const tStyle = TextStyle(color: Colors.white, backgroundColor: Colors.black);
    const expectedFirstTextSpan = 'This is some text';
    late final Widget sut;

    sut = const HighlightText(
      text: tText,
      textToHighlight: tTextToHighlight,
      highlightTextColor: tHighlightTextColor,
      highlightBackgroundColor: tHighlightBackgroundColor,
      style: tStyle,
    );

    /// act

    // Pump the widget tree to render the HighlightText widget.
    await tester.pumpWidget(MaterialApp(home: sut));
    // debugDumpApp();

    ///assert
    // Find the HighlightText widget in the widget tree.
    final textFinder = find.byKey(const Key('NormalText'));
    expect(textFinder, findsOneWidget);

    // Access the RichText-Widget
    final textWidget = tester.widget<Text>(textFinder);

    // Verify 1st TextSpan is Highlighted
    expect(textWidget.data, equals(expectedFirstTextSpan));
    expect(textWidget.style?.color, equals(tStyle.color));
    expect(textWidget.style?.backgroundColor, equals(tStyle.backgroundColor));
  });
}
