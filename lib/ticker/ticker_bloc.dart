import 'package:example/ticker/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'ticker_event.dart';
part 'ticker_state.dart';


class TickerBloc extends Bloc<TickerEvent, TickerState> {
  /// {@macro ticker_bloc}
  TickerBloc(Ticker ticker) : super(TickerInitial()) {
    on<TickerStarted>(
          (event, emit) async {
        await emit.onEach<int>(
          ticker.tick(),
          onData: (tick) => add(_TickerTicked(tick)),
        );
        emit(const TickerComplete());
      },
    );

    on<_TickerTicked>((event, emit) => emit(TickerTickSuccess(event.tick)));
  }
}