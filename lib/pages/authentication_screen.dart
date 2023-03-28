import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../bloc/bloc_authentication/authentication_state.dart';
import '../cubit/cubit_authentication/authentication_cubit.dart';
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  late AuthenticationCubit _authenticationCubit;



  @override
  void initState() {
    super.initState();
    _authenticationCubit = AuthenticationCubit();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          log("state1==$state");
          if (state is AuthenticationSuccess) {
            Navigator.pushNamed(context, "/home");

          } else if (state is AuthenticationFailure) {
            // Show an error message on failure
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        bloc: _authenticationCubit,
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            log("state==$state");
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _authenticationCubit.login(
                          _usernameController.text, _passwordController.text);
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      _authenticationCubit.logout();
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _authenticationCubit.close();
    super.dispose();
  }
}
