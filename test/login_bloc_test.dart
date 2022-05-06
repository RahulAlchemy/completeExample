import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:example/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LoginBloc loginBloc;
  setUp(() {
    EquatableConfig.stringify = true;
    loginBloc = LoginBloc();
  });
  blocTest<LoginBloc, LoginState>("initial state",
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(EmailChanged(""));
        bloc.add(PasswordChanged(""));
      },
      expect: () => [LoginState()]);
  blocTest<LoginBloc, LoginState>("wrong data state",
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(EmailChanged("fdddffd"));
        bloc.add(PasswordChanged("dfgfgf"));
        bloc.add(OnLogin());
      },
      expect: () => [
            LoginState(
                email: "fdddffd",
                password: "",
                canLogin: false,
                state: LoginButtonState.disable),
            LoginState(
                email: "fdddffd",
                password: "dfgfgf",
                canLogin: true,
                state: LoginButtonState.enable),
        LoginState(
            email: "fdddffd",
            password: "dfgfgf",
            canLogin: false,
            state: LoginButtonState.progress),
          ]);

  blocTest<LoginBloc, LoginState>("Correct data state",
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(EmailChanged("rahul@gmail.com"));
        bloc.add(PasswordChanged("1234"));
        bloc.add(OnLogin());
      },
      expect: () => [
        LoginState(
            email: "rahul@gmail.com",
            password: "",
            canLogin: false,
            state: LoginButtonState.disable),
        LoginState(
            email: "rahul@gmail.com",
            password: "1234",
            canLogin: true,
            state: LoginButtonState.enable),
        LoginState(
            email: "rahul@gmail.com",
            password: "1234",
            canLogin: false,
            state: LoginButtonState.progress),
      ]);
}

