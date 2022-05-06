
import 'package:example/bloc_cubit/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc.dart';

class BlocStreamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopPage();
}

class _ShopPage extends State<BlocStreamPage> {
  late CartBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CartBloc(MovieRepository()),
        child: Builder(builder: (context) {
          bloc=BlocProvider.of<CartBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add to Cart'),
             /* actions: [
                BlocBuilder<CartBloc>(
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
              ],*/
            ),
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(),
                ),
                StreamBuilder<CartState>(
                  stream:bloc.currentState,
                  initialData: CartLoading(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data is CartLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (snapshot.data is CartError) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Icon(Icons.close),
                        ),
                      );
                    } else if (snapshot.data is CartLoaded) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: Text(bloc.moviesList[index].title),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                    NetworkImage(bloc.moviesList[index].urlImage),
                                  ),
                                ),
                              );
                            },
                            childCount: bloc.moviesList.length, // 1000 list items
                          ));
                    } else {
                      return SliverToBoxAdapter(child: Container());
                    }
                  },
                ),
              ],
            ),
          );
        }));
  }
}