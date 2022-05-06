import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/mobx/mobx_product_viemodel.dart';
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

void main(){
 late  MobxProductViewModel viewModel;
 late  MockMovieRepository repository;
 setUp((){
   repository=MockMovieRepository();
   viewModel=MobxProductViewModel(repository);
 });

 test("Load data", () async {
  final futureData= viewModel.getData();
  expect(viewModel.isLoading, true);
  await futureData;
  expect(viewModel.isLoading, false);
  expect(viewModel.productList, item);
  viewModel.itemInCart(item[0]);
  viewModel.itemInCart(item[1]);
  expect(viewModel.cartList, [item[0],item[1]]);
  viewModel.itemInCart(item[1]);
  expect(viewModel.cartList, [item[0]]);
 });


}