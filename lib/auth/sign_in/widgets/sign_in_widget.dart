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
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  // late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
    //   if (_redirecting) return;
    //   final session = data.session;
    //   if (session != null) {
    //     _redirecting = true;
    //     Navigator.of(context).pushReplacementNamed('/account');
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _signUp() async {
    Navigator.of(context).pushReplacementNamed('/login/sing_up');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        debugPrint(state.toString());
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
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white,
            // shadowColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text('Авторизация'),
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  Expanded(child: Container()),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SignInBloc>().add(SignInButtonPressed(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                      },
                      child: Text(_isLoading ? 'Loading' : 'Войти'),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context
                            .read<SignInBloc>()
                            .add(SignInShouldShowRegistration());
                      },
                      child: const Text('Регистрация')),
                  const SizedBox(
                    height: 100,
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
