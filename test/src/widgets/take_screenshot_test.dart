// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:marpert_flutter_utils/marpert_flutter_utils.dart';
//
// void main() {
//   testWidgets('takeScreenshot() returns a valid Uint8List', (WidgetTester tester) async {
//     final widgetKey = GlobalKey();
//     final container = RepaintBoundary(
//       key: widgetKey,
//       child: Container(
//         color: Colors.blue, // Your widget to be captured
//       ),
//     );
//
//     // Add the container to the test widget tree
//     await tester.pumpWidget(container);
//     tester.pumpAndSettle();
//
//     // Take a screenshot of the widget.
//     final screenshot = await takeScreenshot(widgetKey);
//
//     expect(screenshot, isNotNull);
//     expect(screenshot, isA<Uint8List>());
//   });
// }
// //
// // void main() {
// //   testWidgets('takeScreenshot() returns a valid Uint8List', (WidgetTester tester) async {
// //     // Build a widget that calls the takeScreenshot() function.
// //     const widget = TestWidget();
// //
// //     // Pump the widget into the test environment.
// //     await tester.pumpWidget(const MaterialApp(home: widget));
// //
// //     // Take a screenshot of the widget.
// //     final Uint8List? screenshot = await takeScreenshot(entireScreenKey);
// //
// //     // Verify that the screenshot is not null.
// //     expect(screenshot, isNotNull);
// //   });
// // }
// //
// // final GlobalKey entireScreenKey = GlobalKey();
// //
// // class TestWidget extends StatelessWidget {
// //   const TestWidget({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return RepaintBoundary(
// //       key: entireScreenKey,
// //       child: const Text('Hello, world!'),
// //     );
// //   }
// // }
