

import 'package:mobx/mobx.dart';

import '../bloc_cubit/movie_repository.dart';
import '../model/movie_model.dart';
part 'mobx_product_viemodel.g.dart';
class MobxProductViewModel =_MobxProductViewModel with _$MobxProductViewModel;
abstract class _MobxProductViewModel with Store{
  final MovieRepository repository;
  @observable
  bool isLoading=false;
  @observable
  ObservableList<MovieModel> productList=ObservableList();
  @observable
  ObservableList<MovieModel> cartList=ObservableList();

  _MobxProductViewModel(this.repository);

  @computed
  int get cartCount => cartList.length;

  Future<void> getData() async {
    isLoading=true;
    final list = await repository.getMovies();
    isLoading=false;
    productList.clear();
    productList.addAll(list);
  }

  void itemInCart(MovieModel movieModel ){
    if (cartList
        .contains(movieModel)) {
      cartList.remove(movieModel);
    } else {
      cartList.add(movieModel);
    }
  }



}