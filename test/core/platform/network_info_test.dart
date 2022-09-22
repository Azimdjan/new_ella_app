import 'package:ella/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionCheckerPlus])
void main() {
  late InternetConnectionCheckerPlus internetConnectionCheckerPlus;
  late NetworkInfo networkInfo;

  setUp(() {
    internetConnectionCheckerPlus = MockInternetConnectionCheckerPlus();
    networkInfo = NetworkInfoImpl(internetConnectionCheckerPlus);
  });

  test('check net connection', () async {
    when(internetConnectionCheckerPlus.hasConnection)
        .thenAnswer((realInvocation) async => true);
    final result = await networkInfo.isConnected;
    verify(internetConnectionCheckerPlus.hasConnection);
    verifyNoMoreInteractions(internetConnectionCheckerPlus);
    expect(result, true);
  });
}
