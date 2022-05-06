// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_product_viemodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxProductViewModel on _MobxProductViewModel, Store {
  Computed<int>? _$cartCountComputed;

  @override
  int get cartCount =>
      (_$cartCountComputed ??= Computed<int>(() => super.cartCount,
              name: '_MobxProductViewModel.cartCount'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_MobxProductViewModel.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$productListAtom =
      Atom(name: '_MobxProductViewModel.productList', context: context);

  @override
  ObservableList<MovieModel> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(ObservableList<MovieModel> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  late final _$cartListAtom =
      Atom(name: '_MobxProductViewModel.cartList', context: context);

  @override
  ObservableList<MovieModel> get cartList {
    _$cartListAtom.reportRead();
    return super.cartList;
  }

  @override
  set cartList(ObservableList<MovieModel> value) {
    _$cartListAtom.reportWrite(value, super.cartList, () {
      super.cartList = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
productList: ${productList},
cartList: ${cartList},
cartCount: ${cartCount}
    ''';
  }
}
