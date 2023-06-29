part of 'login_bloc.dart';


@immutable
abstract class LoginState {}

class LoggedIn extends LoginState {
  @override
  String toString() {
    return "LoggedIn";
  }
}

class NotLoggedIn extends LoginState {
  @override
  String toString() {
    return "NotLoggedIn";
  }
}

class NotRegistered extends LoginState {
  @override
  String toString() {
    return "NotLoggedIn";
  }
}

class LoginError extends LoginState {
  @override
  String toString() {
    return "LoginError";
  }
}
