import 'package:core/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/main/classesList/bloc/classes_list_bloc.dart';
import 'package:testing_app/main/service/main_service_impl.dart';
import 'package:testing_app/navigation/navigation_cubit.dart';
import 'package:testing_app/navigation/root_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmprogresshud/progresshud.dart';
import 'package:testing_app/profile/profile/bloc/profile_bloc.dart';
import 'package:testing_app/profile/service/profile_service_impl.dart';
import 'package:testing_app/results/resultsList/bloc/results_list_bloc.dart';
import 'package:testing_app/results/service/results_service_impl.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(profileService: ProfileServiceImpl()),
          child: Container(),
        ),
        BlocProvider<ClassesListBloc>(
          create: (context) => ClassesListBloc(MainServiceImpl()),
          child: Container(),
        ),
        BlocProvider<ResultsListBloc>(
          create: (context) => ResultsListBloc(ResultsServiceImpl()),
          child: Container(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(ProfileServiceImpl()),
          child: Container(),
        ),
      ],
      child: ProgressHud(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: MaterialColor(
            //   ColorConstants.darkBlue.value,
            //   <int, Color>{
            //     50: ColorConstants.darkBlue.withOpacity(0.1),
            //     100: ColorConstants.darkBlue.withOpacity(0.2),
            //     200: ColorConstants.darkBlue.withOpacity(0.3),
            //     300: ColorConstants.darkBlue.withOpacity(0.4),
            //     400: ColorConstants.darkBlue.withOpacity(0.5),
            //     500: ColorConstants.darkBlue.withOpacity(0.6),
            //     600: ColorConstants.darkBlue.withOpacity(0.7),
            //     700: ColorConstants.darkBlue.withOpacity(0.8),
            //     800: ColorConstants.darkBlue.withOpacity(0.9),
            //     900: ColorConstants.darkBlue.withOpacity(1.0),
            //   },
            // ),
            primarySwatch: MaterialColor(
              ColorConstants.green.value,
              <int, Color>{
                50: ColorConstants.green.withOpacity(0.1),
                100: ColorConstants.green.withOpacity(0.2),
                200: ColorConstants.green.withOpacity(0.3),
                300: ColorConstants.green.withOpacity(0.4),
                400: ColorConstants.green.withOpacity(0.5),
                500: ColorConstants.green.withOpacity(0.6),
                600: ColorConstants.green.withOpacity(0.7),
                700: ColorConstants.green.withOpacity(0.8),
                800: ColorConstants.green.withOpacity(0.9),
                900: ColorConstants.green.withOpacity(1.0),
              },
            ),
          ),
          home: RootScreen(),
        ),
      ),
    );
  }
}
