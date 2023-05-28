import 'package:core/basic_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:testing_app/auth/sign_up/page/sign_up_page.dart';
import 'package:core/alert_dialog.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  // late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Авторизация'),
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.white,
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              debugPrint(state.textFields.toString());
              if (state is SignInSuccessLogin) {
                debugPrint('pop');
                Navigator.pop(context, 'returned');
              }
              if (state is SignInShowRegistration) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SignUpPage();
                    },
                  )).then((value) {
                    context.read<SignInBloc>().add(SignInReterned());
                    if (value == 'returned') {
                      Navigator.pop(context, 'returned');
                    }
                  });
                });
              }
              if (state is SignInError) {
                showAlertDialog(context, state.message);
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 24, right: 24),
                      child: BasicTextFieldWidget(
                        onChanged: (value) {
                          context.read<SignInBloc>().add(SignInTextChanged(key: 'email', value: value));
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
                          context.read<SignInBloc>().add(SignInTextChanged(key: 'password', value: value));
                        },
                        controller: _passwordController,
                        error: state.textFields['password'],
                        label: 'Пароль',
                        hintText: 'Пароль',
                      ),
                    ),
                    const SizedBox(height: 100),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<SignInBloc>().add(
                                  SignInButtonPressed(textFields: {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                  }),
                                );
                          },
                          child: const Text('ВОЙТИ'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 24, left: 24, right: 24),
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<SignInBloc>()
                              .add(SignInShouldShowRegistration());
                        },
                        child: const Text('РЕГИСТРАЦИЯ'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
