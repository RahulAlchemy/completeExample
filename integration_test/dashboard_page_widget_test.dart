
import 'package:equatable/equatable.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/dashboard/dashboard_page.dart';
import 'package:example/dashboard/product_bloc.dart';
import 'package:example/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:integration_test/integration_test.dart';
final item = <MovieModel>[
  const MovieModel(
      title: "KGF chapter 1 ",
      urlImage:
      ""),
  const MovieModel(
      title: "KGF chapter 2 ",
      urlImage:
      ""),
  const MovieModel(
      title: "KGF chapter 3 ",
      urlImage:
      "")
];

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<List<MovieModel>> getMovies() async {
   await Future.delayed(const Duration(seconds: 2));
   return item;
  }
}
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockMovieRepository repository;
  setUp(() {
    EquatableConfig.stringify = true;
    repository = MockMovieRepository();
    // mockMovies();
  });

  Widget widgetForTesting(){
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ProductBloc(repository),
        child: DashboardPage(),
      ));
  }

  void widgetForIntegrationTesting(){
     runApp(MaterialApp(
        home: BlocProvider(
          create: (_) => ProductBloc(repository),
          child: DashboardPage(),
        )));
  }

  testWidgets("Widget displayed", (tester) async{
    await tester.pumpWidget(widgetForTesting());
    expect(find.text("Dashboard"), findsOneWidget);
  });

  // testWidgets("Loading Widget displayed", (tester) async{
  //   await tester.pumpWidget(widgetForTesting());
  //   expect(find.byKey(const Key("CartCount")), findsNothing);
  //   await tester.pump(const Duration(milliseconds: 100));
  //   expect(find.byKey(const Key("CircularProgressIndicator")), findsOneWidget);
  //   await tester.pumpAndSettle();
  //   await tester.pump(const Duration(seconds: 2));
  //   expect(find.byKey(const Key("CircularProgressIndicator")), findsNothing);
  //   expect(find.byKey(const Key("CartCount")), findsOneWidget);
  //   expect(find.byType(ListView), findsOneWidget);
  //   expect(find.byType(Card), findsNWidgets(3));
  // });

  testWidgets("integration test", (tester) async {
    widgetForIntegrationTesting();
    await tester.pumpAndSettle();
    // await tester.pumpWidget(widgetForTesting());
    await tester.pump(const Duration(seconds: 4));
    await  tester.tap(find.byKey(const Key("0_add_cart")));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.text("1"), findsOneWidget);
    await  tester.tap(find.byKey(const Key("1_add_cart")));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.text("2"), findsOneWidget);
    await  tester.tap(find.byKey(const Key("0_add_cart")));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.text("1"), findsOneWidget);
    // await expectLater(find.byType(MaterialApp), matchesGoldenFile("main.png"));

  });
}