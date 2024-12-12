part of "auth_status_bloc.dart";

enum AuthStatus {
  initial,
  submittingEmail,
  successLogIn,
  successSignUp,
  error,
}

enum AuthModes { login, signUp }

extension Names on AuthModes {
  String get getName {
    switch (this) {
      case AuthModes.login:
        return StringManger.login;
      case AuthModes.signUp:
        return StringManger.signUp;
    }
  }
}

class AuthStates extends Equatable {
  final AuthStatus status;
  final AuthModes mode;

  const AuthStates(
      {required this.status,
      required this.mode,
    });

  factory AuthStates.initial(AppUser? appUser) {
    return const AuthStates(
        status: AuthStatus.initial,
        mode: AuthModes.login,
       );
  }

  @override
  List<Object?> get props => [status, mode];

  AuthStates copyWith(
      {AuthStatus? status,
      AuthModes? mode,
     }) {
    return AuthStates(
      status: status ?? this.status,
      mode: mode ?? this.mode,
    );
  }
}
