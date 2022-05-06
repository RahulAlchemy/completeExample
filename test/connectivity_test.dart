import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example/connectivity/connectivity_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity {
  @override
  Future<ConnectivityResult> checkConnectivity() {
    return Future.value(ConnectivityResult.mobile);
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      Stream.fromIterable([ConnectivityResult.none, ConnectivityResult.wifi]);
}

void main() {
  late MockConnectivity connectivity;
  late ConnectivityBloc connectivityBloc;

  setUp(() {
    connectivity = MockConnectivity();
    connectivityBloc = ConnectivityBloc(connectivity);
  });

  blocTest<ConnectivityBloc, ConnectivityState>("initial connection",
      build: () => connectivityBloc,
      act: (bloc) {
        bloc.add(ConnectivityStartedEvent());
      },
      expect: () => [
            ConnectionChangeState(ConnectivityResult.mobile),
            ConnectionChangeState(ConnectivityResult.none),
            ConnectionChangeState(ConnectivityResult.wifi)
          ]);

  blocTest<ConnectivityBloc, ConnectivityState>("Listen connection",
      build: () => connectivityBloc,
      seed:()=>ConnectionChangeState(ConnectivityResult.mobile) ,
      act: (bloc) {
        bloc.add(ConnectivityListenChangeEvent());
      },
      expect: () => [
        ConnectionChangeState(ConnectivityResult.none),
        ConnectionChangeState(ConnectivityResult.wifi)
      ]);
}
