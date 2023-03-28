import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_authentication/authentication_state.dart';



class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void login(String username, String password) async {
    log("userName==${username}");
    emit(AuthenticationLoading());
    // Call your authentication API and handle success/failure
    bool isAuthenticated =  authenticateUser(username, password);
    if (isAuthenticated) {
      log("login");
      emit(AuthenticationSuccess());
    } else {
      log("fail");
      emit(AuthenticationFailure( error: 'Invalid username or password'));
    }
  }

  void logout() {
    emit(AuthenticationInitial());
  }

  bool authenticateUser(String username, String password)  {
    if(username=="admin"&&password=="admin"){
      return true;
    }
    return false;
  }
}
