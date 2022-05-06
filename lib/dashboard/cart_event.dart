
part  of'product_bloc.dart';

abstract class CartEvent extends Equatable{}

class OnStarted extends CartEvent{

  @override
  List<Object?> get props => [];
}

class NewItemAdded extends CartEvent{
  final MovieModel item;
   NewItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}
class ItemRemoved extends CartEvent{
 final MovieModel item;
  ItemRemoved(this.item);

  @override
  List<Object?> get props => [item];
}