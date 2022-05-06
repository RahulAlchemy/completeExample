import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/dashboard/dashboard_page.dart';
import 'package:example/dashboard/product_bloc.dart';
import 'package:example/login/login_bloc.dart';
import 'package:example/login/login_page.dart';
import 'package:example/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

final item = <MovieModel>[
  const MovieModel(title: "KGF chapter 1 ", urlImage: ""),
  const MovieModel(title: "KGF chapter 2 ", urlImage: ""),
  const MovieModel(title: "KGF chapter 3 ", urlImage: "")
];

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<List<MovieModel>> getMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    return item;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  void widgetForIntegrationTesting() {
    runApp(MaterialApp(
        home: MultiProvider(
            providers: [
          Provider(create: (_) => LoginBloc()),
          Provider(create: (_) => ProductBloc(MockMovieRepository())),
        ],
            child: Builder(builder: (context) {
              return LoginPage();
            }))));
  }

  testWidgets("integration test", (tester) async {
    widgetForIntegrationTesting();
    await tester.pumpAndSettle();
    /* await  tester.tap(find.byKey(const Key("loginBtn")));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await  tester.enterText(find.byKey(const Key("emailInput")), "rahul");
    await  tester.enterText(find.byKey(const Key("passwordInput")), "1234");
    await  tester.tap(find.byKey(const Key("loginBtn")));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(LoginPage), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));*/
    await tester.enterText(
        find.byKey(const Key("emailInput")), "rahul@gmail.com");
    await tester.enterText(find.byKey(const Key("passwordInput")), "1234");
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("loginBtn")));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsNothing);
    // expect(find.byType(DashboardPage), findsOneWidget);
  });
}
