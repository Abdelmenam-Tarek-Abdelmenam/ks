part of "auth_status_bloc.dart";

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object?> get props => [];
}


class RegisterUserDataEvent extends AuthStatusEvent {
  final String name;
  const RegisterUserDataEvent(this.name);
}

class ChangeAuthModeEvent extends AuthStatusEvent {
  final AuthModes mode;
  const ChangeAuthModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}

class LoginInUsingEmailEvent extends AuthStatusEvent {
  final String email;
  final String password;

  const LoginInUsingEmailEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpInUsingEmailEvent extends AuthStatusEvent {
  final String email;
  final String password;

  const SignUpInUsingEmailEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}