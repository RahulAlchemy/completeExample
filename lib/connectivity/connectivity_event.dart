
part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable{}

class ConnectivityStartedEvent extends ConnectivityEvent{
  @override
  List<Object?> get props => [];

}

class ConnectivityListenChangeEvent extends ConnectivityEvent{
  @override
  List<Object?> get props => [];

}

class ConnectivityChangedEvent extends ConnectivityEvent{
  final ConnectivityResult result;
  ConnectivityChangedEvent(this.result);
  @override
  List<Object?> get props => [result];

}