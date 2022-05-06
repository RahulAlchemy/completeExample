import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:example/model/movie_model.dart';
import 'package:flutter/material.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<MovieEvent, CartState> {
  CartBloc(this.repository) : super(CartLoading()) {
    on<CartState>(event, emit) async {
      await _fetchData(emit);
    }
      // transformer: restartable(), // ADD THIS LINE);
  }

  List<MovieModel> movies = [];
  List<MovieModel> cartItems = [];

  final MovieRepository repository;

  Future<void> getData() async {
    emit(CartLoading());
    try{
      movies = await repository.getMovies();
      debugPrint("pass1 :: ${movies.length}");
     emit(CartLoaded(movies));
     print("pass1");
    }
    catch(_){
      emit(CartError());
    }
  }

  void addCartItem(MovieModel movie){
    emit(CartItemOnAdding(cartItems.length,movie));
    if(!cartItems.contains(movie)) {
      cartItems.add(movie);
    } else {
      cartItems.remove(movie);
    }
    emit(CartItemOnAdded(cartItems.length,movie));
  }

  Future<void> _fetchData(
      Emitter<CartState> emit,) async {
    print("padd1");
    emit(CartLoading());
    try{
      movies = await repository.getMovies();
      debugPrint("pass1 :: ${movies.length}");
      emit(CartLoaded(movies));
      print("pass1");
    }
    catch(_){
      emit(CartError());
    }
  }


}
