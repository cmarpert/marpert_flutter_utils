import 'package:flutter/services.dart';

//todo: rotates, but does not restore all possibilities, rotation 90° is not possible
// maybe make it available from device entity
void toLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void toPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
