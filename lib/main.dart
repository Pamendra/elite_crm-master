import 'package:elite_crm/Bloc/AddReportBloc.dart';
import 'package:elite_crm/Bloc/UserUpdateBloc/UserUpdateBloc.dart';
import 'package:elite_crm/Screens/Homepage.dart';
import 'package:elite_crm/Screens/LoginScreen/login_screen.dart';
import 'package:elite_crm/Screens/Splash_Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'Bloc/Login_Bloc/LoginBloc.dart';
import 'Bloc/RegistrationBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc()),
        BlocProvider<UserUpdateBloc>(
            create: (context) => UserUpdateBloc()),
        BlocProvider<regUpdateBloc>(
            create: (context) => regUpdateBloc()),
        BlocProvider<AddreportBloc>(
            create: (context) => AddreportBloc()),
      ],

      child:  Sizer(builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }),
    );
  }
}



