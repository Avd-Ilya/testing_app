import 'package:core/alert_dialog.dart';
import 'package:core/basic_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/navigation/navigation_cubit.dart';

import '../bloc/sign_up_bloc.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late final TextEditingController _fioController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;

  @override
  void initState() {
    _fioController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fioController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpSuccessedRegister) {
          Navigator.pop(context, 'returned');
          // context.read<NavigationCubit>().onAppear();
        }
        if (state is SignUpError) {
          showAlertDialog(context, state.message);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Регистрация"),
          ),
          body: SafeArea(
            child: Container(
              // color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 24, right: 24),
                      child: BasicTextFieldWidget(
                        onChanged: (value) {
                          context
                              .read<SignUpBloc>()
                              .add(SignUpTextChanged(key: 'fio', value: value));
                        },
                        controller: _fioController,
                        error: state.textFields['fio'],
                        label: 'ФИО',
                        hintText: 'ФИО',
                        inputFormatters: [],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: BasicTextFieldWidget(
                        onChanged: (value) {
                          context.read<SignUpBloc>().add(
                              SignUpTextChanged(key: 'email', value: value));
                        },
                        controller: _emailController,
                        error: state.textFields['email'],
                        label: 'Электронная почта',
                        hintText: 'Электронная почта',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: BasicTextFieldWidget(
                        onChanged: (value) {
                          context.read<SignUpBloc>().add(SignUpTextChanged(
                                key: 'password',
                                value: value,
                                repeatedValue: _repeatPasswordController.text,
                              ));
                        },
                        controller: _passwordController,
                        error: state.textFields['password'],
                        label: 'Пароль',
                        hintText: 'Пароль',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: BasicTextFieldWidget(
                        onChanged: (value) {
                          context.read<SignUpBloc>().add(
                                SignUpTextChanged(
                                  key: 'repeatedPassword',
                                  value: value,
                                  repeatedValue: _passwordController.text,
                                ),
                              );
                        },
                        controller: _repeatPasswordController,
                        error: state.textFields['repeatedPassword'],
                        label: 'Повторите пароль',
                        hintText: 'Повторите пароль',
                      ),
                    ),
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24, bottom: 50, left: 24, right: 24),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<SignUpBloc>()
                                .add(SignUpButtonPressed(textFields: {
                                  'fio': _fioController.text,
                                  'email': _emailController.text,
                                  'password': _passwordController.text,
                                  'repeatedPassword':
                                      _repeatPasswordController.text,
                                }));
                          },
                          child: const Text('ЗАРЕГИСТРИРОВАТЬСЯ'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
