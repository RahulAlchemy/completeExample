
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_bloc.dart';

class   DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(OnStarted());
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return SizedBox(
                      key:const Key("CartCount"),
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
                                  "${state.cartItem.length}",
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
                    return const SizedBox();
                  }
                })
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator(),key: Key("CircularProgressIndicator"),);
            } else if (state is ProductLoaded) {
              return ListView.builder(itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.list[index].title),
                    leading: state.list[index].urlImage.isNotEmpty?CircleAvatar(
                      backgroundImage:
                      NetworkImage(state.list[index].urlImage)):const SizedBox(),
                    trailing: BlocBuilder<ProductBloc, ProductState>(
                        builder: (context,childState) {
                          debugPrint("childState $childState");
                          if(childState is ProductLoaded) {
                            return IconButton(
                                key: Key("${index}_add_cart"),
                                onPressed: () {
                                  if(childState.cartItem.contains(state.list[index])) {
                                    context
                                        .read<ProductBloc>()
                                        .add(ItemRemoved(state.list[index]));
                                  }
                                  else{
                                    context
                                        .read<ProductBloc>()
                                        .add(NewItemAdded(state.list[index]));
                                  }
                                },
                                icon: childState.cartItem.contains(state.list[index])
                                    ? const Icon(Icons.remove_shopping_cart)
                                    : const Icon(Icons.add_shopping_cart));
                          }
                          else {
                            return const SizedBox();
                          }
                        }
                    ),
                  ),
                );

              },itemCount: state.list.length,key:const Key('ListView'),);
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ));
  }
}
