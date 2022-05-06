import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../bloc_cubit/movie_repository.dart';
import '../model/movie_model.dart';

part 'cart_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<CartEvent, ProductState> {
  final MovieRepository repository;
  ProductBloc(this.repository) : super(ProductInit()) {
    on<OnStarted>(_loadProduct);
    on<NewItemAdded>(_itemAddedInCart);
    on<ItemRemoved>(_itemRemovedInCart);

  }

  Future<void> _loadProduct(CartEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final list = await repository.getMovies();
    emit(ProductLoaded(list, const []));
  }

  void _itemAddedInCart(NewItemAdded event, Emitter<ProductState> emit) {
    List<MovieModel> item=[];
   final stateCurrent= (state as ProductLoaded);
   item.addAll(stateCurrent.cartItem);
   item.add(event.item);
   emit(stateCurrent.copyWith(cartItem:item));
  }
  void _itemRemovedInCart(ItemRemoved event, Emitter<ProductState> emit) {
    List<MovieModel> item=[];
    final stateCurrent= (state as ProductLoaded);
    item.addAll(stateCurrent.cartItem);
    item.remove(event.item);
    emit(stateCurrent.copyWith(cartItem:item));
  }

}
