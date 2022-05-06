part of 'login_bloc.dart';

enum LoginButtonState{disable,enable,progress}

class LoginState extends Equatable{
  LoginState({this.email='', this.password='', this.state=LoginButtonState.disable, this.canLogin=false});
  String email;
  String password;
  LoginButtonState state;
  bool canLogin;


  LoginState copyWith({
    String? email,
    String? password,
    LoginButtonState? state,
    bool? canLogin
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      state: state ?? this.state,
      canLogin: canLogin??this.canLogin
    );
  }
  @override
  List<Object?> get props => [email,password,state,canLogin];
}