import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DeviceType {
  mobile('mobile'),
  tablet('tablet'),
  laptop('laptop');

  const DeviceType(this.name);
  final String name;
}

enum DeviceOrientationsAllowed {
  all([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]),
  landscapeOnly([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]),
  portraitOnly([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  const DeviceOrientationsAllowed(this.list);
  final List<DeviceOrientation> list;
}

class DeviceUtils {
  final Size size;
  final Function(List<DeviceOrientation>) _orientationSetter;
  DeviceOrientationsAllowed _deviceOrientationsAllowed = DeviceOrientationsAllowed.all;

  DeviceUtils._({required this.size, required Function(List<DeviceOrientation>) orientationSetter})
      : _orientationSetter = orientationSetter;

  // for testing -> SystemChrome.setPreferredOrientation can be replaced with Fake, since class is abstract and cannot be mocked
  @visibleForTesting
  static DeviceUtils instanceFor({required size, required orientationSetter}) {
    return DeviceUtils._(size: size, orientationSetter: orientationSetter);
  }

  factory DeviceUtils({required size}) {
    const orientationSetter = SystemChrome.setPreferredOrientations;
    return DeviceUtils._(size: size, orientationSetter: orientationSetter);
  }

  static DeviceUtils get fromMediaQuery {
    final deviceData = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
    const orientationSetter = SystemChrome.setPreferredOrientations;
    return DeviceUtils._(size: deviceData.size, orientationSetter: orientationSetter);
  }

  // Bildshirm:                 930 * 1680
  // Tablet Lenovo:            1280 *  752
  // Handy Samsung Galaxy A53 : 866 *  441

  DeviceType get deviceType {
    if (size.longestSide >= 1500) {
      return DeviceType.laptop;
    } else if (size.longestSide >= 1000) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  // static final List<DeviceOrientation> _allOrientations = [
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ];
  // static final List<DeviceOrientation> _orientationsLandscapeOnly = [
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ];
  // static final List<DeviceOrientation> _orientationsPortraitOnly = [
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ];

  DeviceOrientationsAllowed get deviceOrientationsAllowed => _deviceOrientationsAllowed;

  Future<void> setOrientationToLandscapeOnly() async {
    const allowed = DeviceOrientationsAllowed.landscapeOnly;
    await _orientationSetter(allowed.list);
    _deviceOrientationsAllowed = allowed;
  }

  Future<void> setOrientationToPortraitOnly() async {
    const allowed = DeviceOrientationsAllowed.portraitOnly;
    await _orientationSetter(allowed.list);
    _deviceOrientationsAllowed = allowed;
  }

  Future<void> setOrientationToAll() async {
    const allowed = DeviceOrientationsAllowed.all;
    await _orientationSetter(allowed.list);
    _deviceOrientationsAllowed = allowed;
  }
}
