
part of 'cart_bloc.dart';

abstract class CartState extends Equatable{
  @override
  List<Object> get props => [];
}
// class CartState extends ShopState{}

 class CartLoading extends CartState{

 }
class CartError extends CartState{

}

class CartLoaded extends CartState{
}
class CartItemOnAdding extends CartState{
  final int? items;
  final MovieModel movie;
  CartItemOnAdding(this.items,this.movie);
}
class CartItemOnAdded extends CartState{
  final int? items;
  final MovieModel movie;
  CartItemOnAdded(this.items,this.movie);
}