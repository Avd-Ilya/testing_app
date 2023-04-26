import 'package:flutter/material.dart';
import 'package:testing_app/navigation/navigation_cubit.dart';
import 'package:testing_app/navigation/root_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // await Supabase.initialize(
  //   // TODO: Replace credentials with your own
  //   url: 'https://vgpseeapxkobmqbebqqh.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZncHNlZWFweGtvYm1xYmVicXFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAwMDM2ODksImV4cCI6MTk5NTU3OTY4OX0.X1MJ6osHcB_-RljUGgTQur666NxEL5CtlziAc6AB-Xg',
  // );
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Supabase Flutter',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       // theme: ThemeData.dark().copyWith(
//       //   primaryColor: Colors.green,
//       //   textButtonTheme: TextButtonThemeData(
//       //     style: TextButton.styleFrom(
//       //       foregroundColor: Colors.green,
//       //     ),
//       //   ),
//       //   elevatedButtonTheme: ElevatedButtonThemeData(
//       //     style: ElevatedButton.styleFrom(
//       //       foregroundColor: Colors.white,
//       //       backgroundColor: Colors.green,
//       //     ),
//       //   ),
//       // ),
//       initialRoute: '/',
//       routes: <String, WidgetBuilder>{
//         '/': (_) => const SplashPage(),
//         '/login': (_) => const SignInPage(),
//         '/login/sing_up': (_) => const SingUpPage(),
//         '/account': (_) => const AccountPage(),
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: RootScreen(),
      ),
    );
  }
}