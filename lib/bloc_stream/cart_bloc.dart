import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:example/model/movie_model.dart';
part 'cart_state.dart';

class CartBloc extends Bloc{
  CartBloc(this.repository) : super(CartLoading()) {
    getData();
  }

  final _moviesStateController = StreamController<List<MovieModel>>.broadcast();
  StreamSink<List<MovieModel>> get _inCounter => _moviesStateController.sink;
  Stream<List<MovieModel>> get movies => _moviesStateController.stream;
  List<MovieModel> moviesList =[];

  final _stateController = StreamController<CartState>.broadcast();
  Sink<CartState> get counterEventSink => _stateController.sink;
  Stream<CartState> get currentState => _stateController.stream;


  // List<MovieModel> movies = [];
  List<MovieModel> cartItems = [];

  final MovieRepository repository;

  Future<void> getData() async {
    _stateController.add(CartLoading());
    try{
      moviesList=await repository.getMovies();
      print("pass1 :: ${movies.length}");
      _stateController.add(CartLoaded());
    }
    catch(_){
      _stateController.add(CartError());
    }
  }

  // void addCartItem(MovieModel movie){
  //   emit(CartItemOnAdding(cartItems.length,movie));
  //   if(!cartItems.contains(movie)) {
  //     cartItems.add(movie);
  //   } else {
  //     cartItems.remove(movie);
  //   }
  //   emit(CartItemOnAdded(cartItems.length,movie));
  //
  // }


}
