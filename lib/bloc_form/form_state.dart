
part of 'form_bloc.dart';
class MyFormState extends Equatable {
  const MyFormState({
    this.email = "",
    this.password = "",
    this.status = 0,
  });

  final String email;
  final String password;
  final int status;

  MyFormState copyWith({
    String? email,
    String? password,
    int? status,
  }) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}