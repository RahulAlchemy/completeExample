import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example/connectivity/connectivity_bloc.dart';
import 'package:example/connectivity/connectivity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity {
  @override
  Future<ConnectivityResult> checkConnectivity() async {
    await Future.delayed(const Duration(seconds: 2));
    return ConnectivityResult.none;
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      Stream.periodic(const Duration(seconds: 1), (i) {
        if (i == 0) {
          return ConnectivityResult.wifi;
        } else {
          return ConnectivityResult.mobile;
        }
      });
// Stream.fromIterable([ConnectivityResult.none, ConnectivityResult.wifi]);
}

Widget widgetForTesting() {
  return MaterialApp(
      home: BlocProvider(
    create: (_) => ConnectivityBloc(MockConnectivity()),
    child: const ConnectivityPage(child: SizedBox(key: Key("connection"))),
  ));
}

void main() {
  testWidgets("Widget displayed", (tester) async {
    await tester.pumpWidget(widgetForTesting());
    expect(find.byKey(const Key("noconnection")), findsNothing);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key("connection")), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.byKey(const Key("connection")), findsOneWidget);
    await expectLater(find.byKey(const Key("connection")),
        matchesGoldenFile('golden/widget_displayed_conntuvity.png'));
    // await tester.pump(const Duration(seconds: 2));
    // expect(find.byKey(const Key("connection")), findsOneWidget);

    // await tester.pumpAndSettle();
  });
}
