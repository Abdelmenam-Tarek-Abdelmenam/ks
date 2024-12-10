part of "auth_status_bloc.dart";

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object?> get props => [];
}


class SignUpInUsingEmailEvent extends AuthStatusEvent {
  final String email;
  final String password;
  final String name;

  const SignUpInUsingEmailEvent(this.name , this.email, this.password);

  @override
  List<Object?> get props => [email, password];
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
