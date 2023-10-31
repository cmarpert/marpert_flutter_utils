import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// this method takes a screenshot an retunrs it as a byte Uint8List
/// The target widget must be wrapped in a RepaintBoundary Widget and given
/// the key [widgetKey]
Future<Uint8List?> takeScreenshot(GlobalKey widgetKey) async {
//get paint bound of your app screen or the widget which is wrapped with RepaintBoundary.
  RenderRepaintBoundary bound = widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  ui.Image image = await bound.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData == null) return null;
  return byteData!.buffer.asUint8List();
}
