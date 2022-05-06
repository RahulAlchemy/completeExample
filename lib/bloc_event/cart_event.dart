
part of 'cart_bloc.dart';
abstract class MovieEvent extends Equatable{}

class LoadEvent extends MovieEvent{
  @override
  List<Object?> get props => [];
}

class CartEvent extends MovieEvent{
  @override
  List<Object?> get props => [];
}