import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marpert_flutter_utils/marpert_flutter_utils.dart';

main() {
  group('mobile', () {
    test('given width = 750, height = 500, type should return mobile', () {
      ///arrange
      double tWidth = 750;
      double tHeight = 500;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.mobile);
    });
    test('given width = 500, height = 750, type should return mobile', () {
      ///arrange
      double tWidth = 500;
      double tHeight = 750;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.mobile);
    });
  });

  group('tablet', () {
    test('given width = 1000, height = 500, type should return mobile', () {
      ///arrange
      double tWidth = 1000;
      double tHeight = 500;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.tablet);
    });
    test('given width = 500, height = 1000, type should return mobile', () {
      ///arrange
      double tWidth = 500;
      double tHeight = 1000;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.tablet);
    });
  });
  group('laptop', () {
    test('given width = 1500, height = 500, type should return mobile', () {
      ///arrange
      double tWidth = 1500;
      double tHeight = 500;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.laptop);
    });
    test('given width = 500, height = 1500, type should return mobile', () {
      ///arrange
      double tWidth = 500;
      double tHeight = 1500;

      final sut = Device(size: Size(tWidth, tHeight));

      ///act
      final result = sut.type;

      ///assert
      expect(result, DeviceType.laptop);
    });
  });

  group('setOrientation', () {
    final List<DeviceOrientation> allOrientations = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];

    final List<DeviceOrientation> orientationsLandscapeOnly = [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
    final List<DeviceOrientation> orientationsPortraitOnly = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ];

    test('''setOrientationToPortraitOnly
    ''', () async {
      /// arrange

      final sut = Device.instanceFor(size: Size.zero, orientationSetter: (List<DeviceOrientation> _) {});

      /// act
      await sut.setOrientationToPortraitOnly();

      /// assert
      expect(sut.deviceOrientationsAllowed, DeviceOrientationsAllowed.portraitOnly);
    });

    test('''setOrientationToLandscapeOnly
    ''', () async {
      /// arrange

      final sut = Device.instanceFor(size: Size.zero, orientationSetter: (List<DeviceOrientation> _) {});

      /// act
      await sut.setOrientationToLandscapeOnly();

      /// assert
      expect(sut.deviceOrientationsAllowed, DeviceOrientationsAllowed.landscapeOnly);
    });

    test('''setOrientationToAll
    ''', () async {
      /// arrange

      final sut = Device.instanceFor(size: Size.zero, orientationSetter: (List<DeviceOrientation> _) {});

      /// act
      await sut.setOrientationToAll();

      /// assert
      expect(sut.deviceOrientationsAllowed, DeviceOrientationsAllowed.all);
    });
  });
}
