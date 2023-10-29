import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marpert_flutter_utils/marpert_flutter_utils.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

main() {
  late MockConnectivity mockNetworkConnectionChecker;
  late NetworkInfo sut;

  setUp(() {
    mockNetworkConnectionChecker = MockConnectivity();
    sut = NetworkInfo(networkChecker: mockNetworkConnectionChecker);
  });

  test('should forward the call to Connectivity.checkConnectivity()', () async {
    ///arrange
    when(() => mockNetworkConnectionChecker.checkConnectivity())
        .thenAnswer((_) async => await Future.value(ConnectivityResult.wifi));

    ///act
    final result = await sut.isConnected;

    ///assert
    verify(() => mockNetworkConnectionChecker.checkConnectivity());
  });

  test('should return TRUE if ConnectivityResult != None', () async {
    ///arrange
    final tHasConnection = true;
    when(() => mockNetworkConnectionChecker.checkConnectivity())
        .thenAnswer((_) async => await Future.value(ConnectivityResult.wifi));

    ///act
    final result = await sut.isConnected;

    ///assert
    verify(() => mockNetworkConnectionChecker.checkConnectivity());
    expect(result, tHasConnection);
  });
  test('should return FALSE if ConnectivityResult == None', () async {
    ///arrange
    final tHasConnection = false;
    when(() => mockNetworkConnectionChecker.checkConnectivity())
        .thenAnswer((_) async => await Future.value(ConnectivityResult.none));

    ///act
    final result = await sut.isConnected;

    ///assert
    verify(() => mockNetworkConnectionChecker.checkConnectivity());
    expect(result, tHasConnection);
  });
}
