import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this.connectivity) : super(InitState()) {
    on<ConnectivityStartedEvent>(_initConnectivity);
    on<ConnectivityListenChangeEvent>(_listenChange);
    on<ConnectivityChangedEvent>((event, emit) => emit(ConnectionChangeState(event.result)));
  }

  final Connectivity connectivity;

  Future<void> _initConnectivity(ConnectivityStartedEvent event,
      Emitter<ConnectivityState> emitter) async {
    ConnectivityResult? result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status ${e.message}');
    }
    emitter(ConnectionChangeState(result ?? ConnectivityResult.none));
   add(ConnectivityListenChangeEvent());
  }

  Future<void> _listenChange(ConnectivityListenChangeEvent event,
      Emitter<ConnectivityState> emitter) async {
    await emitter.onEach<ConnectivityResult>(connectivity.onConnectivityChanged,
        onData: (connectivityResult) =>
            add(ConnectivityChangedEvent(connectivityResult)));
  }
}
