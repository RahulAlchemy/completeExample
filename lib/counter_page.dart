import 'package:example/bloc_form/bloc_form_page.dart';
import 'package:example/bloc_stream/shop_page.dart';
import 'package:example/bracket_page.dart';
import 'package:example/bracket_widget.dart';
import 'package:example/login/login_page.dart';
import 'package:example/mobx/mobx_project_page.dart';
import 'package:example/ticker/ticker_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_cubit/movie_page.dart';
import 'bloc_event/shop_page.dart';
import 'counter_cubit.dart';
import 'json_page.dart';
import 'provider_sample/provider_sample_page.dart';

class CounterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CounterPage();
  }
}
class _CounterPage extends State<CounterPage>{
  ValueNotifier<String> notifier=ValueNotifier("Empty");

  @override
  void initState() {
   notifier.addListener(() {
     print("value ${notifier.value}");
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(create: (_)=>CounterCubit(),
    child: Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Counter'),actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>JsonDataPage()));
            }, child:const Text("Bracket"))
          ],),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               Container(child: Text("T000y",style: TextStyle(fontSize: 25),),color: Colors.blueGrey,),
                SizedBox(height: 10,),
                Container(child: RichText(text: TextSpan(text: "abc",style: TextStyle(fontSize: 25)),),color: Colors.blueGrey,),

                BlocBuilder<CounterCubit, int>(
                  builder: (context, state) {
                    return Text('$state', style: textTheme.headline2);
                  },
                ),
                ElevatedButton(onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BlocCubitPage()));
                  notifier.value="AAAAA";
                }, child:const Text("BlocCubit")),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BlocEventPage()));
                }, child:const Text("BlocEvent")),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BlocStreamPage()));
                }, child:const Text("BlocStream")),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BlocFormPage()));
                }, child:const Text("BlocForm")),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage()));
                }, child:const Text("Login")),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TickerPage()));
                }, child:const Text("Ticker")),

                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MobxProjectPage()));
                }, child:const Text("Mobx")),

                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ProviderSamplePage()));
                }, child:const Text("Provider")),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                key: const Key('counterView_increment_floatingActionButton'),
                child: const Icon(Icons.add),
                onPressed: () => context.read<CounterCubit>().increment(),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                key: const Key('counterView_decrement_floatingActionButton'),
                child: const Icon(Icons.remove),
                onPressed: () => context.read<CounterCubit>().decrement(),
              ),
            ],
          ),
        );
      }
    ) );
  }
}