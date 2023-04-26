import 'package:core/alert_dialog.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _fioController,
                    decoration: const InputDecoration(labelText: 'ФИО'),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Пароль'),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _repeatPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Повторите пароль'),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SignUpBloc>().add(SignUpButtonPressed(
                              fio: _fioController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              repeatedPassword: _repeatPasswordController.text,
                            ));
                      },
                      child: const Text('Зарегистрироваться'),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
