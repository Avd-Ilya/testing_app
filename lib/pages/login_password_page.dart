import 'dart:async';

import 'package:core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../libraries/core/lib/constants.dart';

class LoginPasswordPage extends StatefulWidget {
  const LoginPasswordPage({super.key});

  @override
  State<LoginPasswordPage> createState() => _LoginPasswordPageState();
}

class _LoginPasswordPageState extends State<LoginPasswordPage> {
  bool _isLoading = false;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // await supabase.auth.signInWithOtp(
      //   email: _emailController.text,
      //   emailRedirectTo:
      //       kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      // );
      // if (mounted) {
      //   context.showSnackBar(message: 'Check your email for login link!');
      //   _emailController.clear();
      // }
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        context.showSnackBar(message: 'Success Sing Up');
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
        context.showSnackBar(message: 'Success Sing In');
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
      // if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        // _redirecting = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sing Up')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          // const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signUp,
            child: Text(_isLoading ? 'Loading' : 'Sing Up'),
          ),
          TextButton(onPressed: _signIn, child: const Text('Sign In')),
        ],
      ),
    );
  }
}
