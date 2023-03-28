import 'package:bloc_login_form/pages/authentication_screen.dart';
import 'package:bloc_login_form/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit_authentication/authentication_cubit.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
        ),

      ],
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthenticationScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
