import 'package:example/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().onLoginSuccess = onSuccess;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextField(
                      key: const Key("emailInput"),
                      decoration: InputDecoration(
                          hintText: "Email",
                          helperText:
                              "A complete, valid email e.g. joe@gmail.com",
                          errorText: state.email.isEmpty
                              ? "Please ensure the email entered is valid"
                              : null),
                      onChanged: (v) {
                        context.read<LoginBloc>().add(EmailChanged(v));
                      },
                    );
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextField(
                      key: const Key("passwordInput"),
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          helperText: "Password must be 8 more letters",
                          errorText: state.email.isEmpty
                              ? "Please ensure the email password is valid"
                              : null),
                      onChanged: (v) {
                        context.read<LoginBloc>().add(PasswordChanged(v));
                      },
                    );
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      key: const Key("loginBtn"),
                        onPressed: state.state == LoginButtonState.enable
                            ? () {
                                context.read<LoginBloc>().add(OnLogin());
                              }
                            : null,
                        child: state.state == LoginButtonState.progress
                            ? const CircularProgressIndicator()
                            : const Text("Login"));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSuccess() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => DashboardPage()));
}
