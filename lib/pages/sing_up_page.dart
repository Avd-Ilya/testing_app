import 'dart:async';

import 'package:core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../libraries/core/lib/constants.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _fioController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;
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
    _fioController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
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
      var data = await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        var user = data.user!.id;
        debugPrint(user);
        _updateProfile(user);
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

  Future<void> _updateProfile(String id) async {
    setState(() {
      _isLoading = true;
    });
    final userName = _fioController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      // 'id': user!.id,
      'id': id,
      'username': userName,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: 'Successfully updated profile!');
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpeted error occurred');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.red,
          onPressed: () => Navigator.of(context).popAndPushNamed('/'),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   // onPressed: () => Navigator.of(context).pop(),
        // ),
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
                  onPressed: _isLoading ? null : _signUp,
                  child: Text(_isLoading ? 'Loading' : 'Зарегестрироваться'),
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
  }
}
