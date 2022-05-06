import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example/connectivity/connectivity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc_cubit/movie_repository.dart';
import 'connectivity/connectivity_bloc.dart';
import 'counter_page.dart';
import 'dashboard/product_bloc.dart';
import 'login/login_bloc.dart';
import 'mobx/mobx_product_viemodel.dart';
import 'provider_sample/provider_sample_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProviderSampleViewModel>(create: (_) => ProviderSampleViewModel()),
        Provider<MobxProductViewModel>(create: (_) => MobxProductViewModel(MovieRepository())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (_) => LoginBloc()),
          BlocProvider(
              create: (_) => ProductBloc(MovieRepository())),

          BlocProvider(
              create: (_) => ConnectivityBloc(Connectivity())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home:ConnectivityPage(child: CounterPage()),
        ),
      ),
    );
  }
}


