import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../bloc_cubit/movie_repository.dart';
import 'mobx_product_viemodel.dart';

class MobxProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MobxProjectPage();
}

class _MobxProjectPage extends State<MobxProjectPage> {
  late MobxProductViewModel viewModel;

  @override
  void initState() {
    viewModel = context.read<MobxProductViewModel>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      viewModel.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Observer(builder: (_) {
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
                            "${viewModel.cartCount}",
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
            })
          ],
        ),
        body: Stack(children: [
          Observer(builder: (_) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(viewModel.productList[index].title),
                    leading:viewModel.productList[index].urlImage.isNotEmpty? CircleAvatar(
                      backgroundImage: NetworkImage(
                          viewModel.productList[index].urlImage),
                    ):const SizedBox(),
                    trailing: Observer(builder: (context) {
                      return IconButton(
                          onPressed: () {
                            viewModel.itemInCart(viewModel.productList[index]);
                          },
                          icon: viewModel.cartList
                              .contains(viewModel.productList[index])
                              ? const Icon(Icons.remove_shopping_cart)
                              : const Icon(Icons.add_shopping_cart));
                    }),
                  ),
                );
              },
              itemCount: viewModel.productList.length,
            );
          }),
          Observer(builder: (context) {
            return Visibility(
                child: const Center(child: CircularProgressIndicator(),key: Key("CircularProgressIndicator"),),
                visible: viewModel.isLoading);
          })
        ]));
  }
}
