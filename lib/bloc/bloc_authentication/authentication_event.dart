abstract class AuthenticationEvent {}

class LoginButtonPressed extends AuthenticationEvent {
  final String username;
  final String password;

  LoginButtonPressed({required this.username, required this.password});
}

class LogoutButtonPressed extends AuthenticationEvent {}
