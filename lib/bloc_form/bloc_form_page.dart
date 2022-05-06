import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_bloc.dart';

class BlocFormPage extends StatefulWidget {
  const BlocFormPage({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<BlocFormPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<FormBloc, MyFormState>(
              listener: (context, state) {
                if (state.status == 3) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showDialog<void>(
                    context: context,
                    builder: (_) => const SuccessDialog(),
                  );
                }
                if (state.status == 2) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Submitting...')),
                    );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    EmailInput(focusNode: _emailFocusNode),
                    PasswordInput(focusNode: _passwordFocusNode),
                    const SubmitButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      lazy: true,
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. joe@gmail.com',
            errorText: state.email.isEmpty
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<FormBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
            errorText: state.password.isEmpty
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.read<FormBloc>().add(PasswordChanged(password: value));
          },
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status == 1
              ? () => context.read<FormBloc>().add(FormSubmitted())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Icons.info),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Form Submitted Successfully!',
                        softWrap: true,
                      ),
                    ))
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
