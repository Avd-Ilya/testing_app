import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:core/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        context.showSnackBar(message: 'Успешная авторизация!');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _signUp() async {
    Navigator.of(context).pushReplacementNamed('/login/sing_up');
    // setState(() {
    //   _isLoading = true;
    // });

    // try {
    //   // await supabase.auth.signInWithOtp(
    //   //   email: _emailController.text,
    //   //   emailRedirectTo:
    //   //       kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
    //   // );
    //   // if (mounted) {
    //   //   context.showSnackBar(message: 'Check your email for login link!');
    //   //   _emailController.clear();
    //   // }
    //   await supabase.auth.signUp(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    //   if (mounted) {
    //     context.showSnackBar(message: 'Success Sing Up');
    //   }
    // } on AuthException catch (error) {
    //   context.showErrorSnackBar(message: error.message);
    // } catch (error) {
    //   context.showErrorSnackBar(message: 'Unexpected error occurred');
    // }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        // surfaceTintColor: Colors.white,
        // foregroundColor: Colors.white,
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
                  onPressed: _isLoading ? null : _signIn,
                  child: Text(_isLoading ? 'Loading' : 'Войти'),
                ),
              ),
              TextButton(onPressed: _signUp, child: const Text('Регистрация')),
              const SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
