import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/auth/service/auth_service_impl.dart';
import 'package:testing_app/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:testing_app/auth/sign_up/widgets/sign_up_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(AuthServiceImpl()),
      child: const SignUpWidget(),
    );
  }
}
