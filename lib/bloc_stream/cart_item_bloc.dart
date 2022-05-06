
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:example/model/movie_model.dart';

class CartItemBloc extends Bloc{


  final _cartMoviesStateController = StreamController<List<MovieModel>>.broadcast();

  CartItemBloc(initialState) : super(initialState);
  StreamSink<List<MovieModel>> get _inCounter => _cartMoviesStateController.sink;
  Stream<List<MovieModel>> get cartMovies => _cartMoviesStateController.stream;



  Future<bool> isItemInCart(MovieModel movieModel) async {
   return await cartMovies.contains(movieModel);
  }







}
