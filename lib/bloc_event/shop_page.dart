import 'package:dio/dio.dart';
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc.dart';

class BlocEventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopPage();
}

class _ShopPage extends State<BlocEventPage> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CartBloc(MovieRepository()),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add to Cart'),
              actions: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartItemOnAdded) {
                      return SizedBox(
                        width: 40,
                        height: 50,
                        child: Stack(
                          children: [
                            Container(
                              child: const Icon(Icons.shopping_cart,
                                  color: Colors.white, size: 40),
                              margin: const EdgeInsets.only(top: 10),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  child: Text(
                                    "${state.items}",
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    print("pass list builder");
                    if (state is CartLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is CartError) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Icon(Icons.close),
                        ),
                      );
                    } else if (state is CartLoaded) {
                      final movies = state.movies;
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return BlocBuilder<CartBloc, CartState>(
                            builder: (context, state) {
                              return Card(
                                child: ListTile(
                                  title: Text(movies[index].title),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(movies[index].urlImage),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        context
                                            .read<CartBloc>()
                                            .addCartItem(movies[index]);
                                      },
                                      icon: context
                                              .read<CartBloc>()
                                              .cartItems
                                              .contains(movies[index])
                                          ? Icon(Icons.remove_shopping_cart)
                                          : Icon(Icons.add_shopping_cart)),
                                ),
                              );
                            },
                            buildWhen: (previous, current) => current is CartItemOnAdding &&
                                    current.movie.title == movies[index].title
                                ? true
                                : false,
                          );
                        },
                        childCount: movies.length, // 1000 list items
                      ));
                    } else {
                      return SliverToBoxAdapter(child: Container());
                    }
                  },
                  buildWhen: (p, s) {
                    if (s is CartLoaded || s is CartError || s is CartLoaded)
                      return true;
                    else
                      return false;
                  },
                )
              ],
            ),
          );
        }));
  }
}
