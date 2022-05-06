import 'package:equatable/equatable.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/mobx/mobx_product_viemodel.dart';
import 'package:example/mobx/mobx_project_page.dart';
import 'package:example/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

final item = <MovieModel>[
  const MovieModel(
      title: "KGF chapter 1 ",
      urlImage:""),
  const MovieModel(
      title: "KGF chapter 2 ",
      urlImage:""),
  const MovieModel(
      title: "KGF chapter 5",
      urlImage:""
  )        ];

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<List<MovieModel>> getMovies() async {
    await Future.delayed(const Duration(seconds: 2));
    return item;
  }
}

void main() {
  late MobxProductViewModel productBloc;
  late MockMovieRepository repostory;


  setUp(() {
    EquatableConfig.stringify = true;
    // mockMovies();
  });

  Widget widgetForTesting() {
    return MaterialApp(
        home: Provider(
      create: (_) => MobxProductViewModel(MockMovieRepository()),
      child: MobxProjectPage(),
    ));
  }

  testWidgets("Widget displayed", (tester) async {
    await tester.pumpWidget(widgetForTesting());
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byKey(const Key("CircularProgressIndicator")), findsOneWidget);
    await expectLater(find.byKey(const Key("CircularProgressIndicator")),
        matchesGoldenFile('golden/widget_displayed.png'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byKey(const Key("CircularProgressIndicator")), findsNothing);
    await expectLater(find.byType(ListView),
        matchesGoldenFile('golden/widget_displayed1.png'));

  });
}
