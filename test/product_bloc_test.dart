import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/dashboard/product_bloc.dart';
import 'package:example/model/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

final item = <MovieModel>[
  const MovieModel(
      title: "KGF chapter 1 ",
      urlImage:
          "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR-GJWOluiuP4BTtHHg6Kk68cuueul3mwQOMwueqol3kBMrT8c7"),
  const MovieModel(
      title: "KGF chapter 2 ",
      urlImage:
          "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR-GJWOluiuP4BTtHHg6Kk68cuueul3mwQOMwueqol3kBMrT8c7"),
  const MovieModel(
      title: "KGF chapter 3 ",
      urlImage:
          "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR-GJWOluiuP4BTtHHg6Kk68cuueul3mwQOMwueqol3kBMrT8c7")
];

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<List<MovieModel>> getMovies() async {
    await Future.delayed(const Duration(seconds: 1));
    return item;
  }
}

void main() {
  late ProductBloc productBloc;
  late MockMovieRepository repository;
  setUp(() {
    EquatableConfig.stringify = true;
    repository = MockMovieRepository();
    productBloc = ProductBloc(repository);
    // mockMovies();
  });

  group("Product screen", () {
    blocTest<ProductBloc, ProductState>("Loading data",
        build: () => productBloc,
        act: (bloc) {
          bloc.add(OnStarted());
        },
        wait: const Duration(seconds: 1),
        expect: () => [ProductLoading(), ProductLoaded(item, const [])]);

    blocTest<ProductBloc, ProductState>("AddItemInCart",
        build: () => productBloc,
        seed:()=>ProductLoaded(item, const []) ,
        act: (bloc) async {
          bloc.add(NewItemAdded(item[0]));
          bloc.add(NewItemAdded(item[1]));
        },
        wait: const Duration(seconds: 1),
        expect: () => [
              ProductLoaded(item, [item[0]]),
              ProductLoaded(item, [item[0], item[1]])
            ]);
  });


  blocTest<ProductBloc, ProductState>("RemoveItemFromCart",
      build: () => productBloc,
      seed:()=>ProductLoaded(item, [item[0], item[1]]),
      act: (bloc) async {
        bloc.add(ItemRemoved(item[0]));
      },
      expect: () => [
        ProductLoaded(item, [item[1]]),
      ]);

}
