import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connectivity_bloc.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _ConnectivityPageState createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectionChangeState) {
              return state.result == ConnectivityResult.none
                  ? Center(
                   key:const Key("noconnection"),
                  child: Text(
                      'Connection Status: ${state.result.toString()}'))
                  : widget.child;
            } else {
              return widget.child;
            }
          },
        ));

  }
}
