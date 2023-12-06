import 'package:equatable/equatable.dart';
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

class DeviceUtils extends Equatable {
  final Size size;
  final Function(List<DeviceOrientation>) _orientationSetter;
  DeviceOrientationsAllowed _deviceOrientationsAllowed = DeviceOrientationsAllowed.all;

  DeviceUtils._({required this.size, required Function(List<DeviceOrientation>) orientationSetter})
      : _orientationSetter = orientationSetter;

  // for testing -> SystemChrome.setPreferredOrientation can be replaced with Fake, since class is abstract and cannot be mocked
  @visibleForTesting
  static DeviceUtils instanceForTestingOnly({required size, required orientationSetter}) {
    return DeviceUtils._(size: size, orientationSetter: orientationSetter);
  }

  factory DeviceUtils.fromSize({required size}) {
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

  DeviceOrientationsAllowed get deviceOrientationsAllowed => _deviceOrientationsAllowed;

  // convenience getters
  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isLaptop => deviceType == DeviceType.laptop;

  /// set allowed Orientations and rotate for device instances
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

  ///Rotate without creating an instance, -> static methods
  static Future<void> toLandscape() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientationsAllowed.landscapeOnly.list);
  }

  static Future<void> toPortrait() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientationsAllowed.portraitOnly.list);
  }

  @override
  List<Object?> get props => [size, deviceType, deviceOrientationsAllowed];
}
