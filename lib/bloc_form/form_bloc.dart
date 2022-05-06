
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'form_event.dart';
part 'form_state.dart';
class FormBloc extends Bloc<FormEvent, MyFormState> {
  FormBloc() : super(const MyFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<FormEvent, MyFormState> transition) {
    debugPrint("$transition");
    super.onTransition(transition);
  }

  void _onEmailChanged(EmailChanged event, Emitter<MyFormState> emit) {
    final email = event.email;
    emit(state.copyWith(
      email: email.isNotEmpty ? email : event.email,
      status: email.isNotEmpty&&state.password.isNotEmpty?1:0,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<MyFormState> emit) {
    final password = event.password;
    emit(state.copyWith(
      password: password.isNotEmpty ? password : event.password,
      status: state.email.isNotEmpty&& password.isNotEmpty?1:0,
    ));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<MyFormState> emit) {
    final email = state.email;
    emit(state.copyWith(
      email: email,
      status: email.isNotEmpty&& state.password.isNotEmpty?1:0,
    ));
  }

  void _onPasswordUnfocused(
      PasswordUnfocused event,
      Emitter<MyFormState> emit,
      ) {
    final password = state.password;
    emit(state.copyWith(
      password: password,
      status:state.email.isNotEmpty&&password.isNotEmpty?1:0,
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<MyFormState> emit) async {
    final email = state.email;
    final password = state.password;
    emit(state.copyWith(
      email: email,
      password: password,
      status: email.isNotEmpty&& password.isNotEmpty?1:0,
    ));
    if (state.status==1) {
      emit(state.copyWith(status: 2));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: 3));
    }
  }
}