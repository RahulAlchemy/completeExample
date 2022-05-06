
part of 'connectivity_bloc.dart';
abstract class ConnectivityState extends Equatable{

}

class InitState extends ConnectivityState{
  @override
  List<Object?> get props => [];
}

class ConnectionChangeState extends ConnectivityState{
  final ConnectivityResult result;
  ConnectionChangeState(this.result);
  @override
  List<Object?> get props => [result];
}

