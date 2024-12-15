part of "user_info_status_bloc.dart";

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object?> get props => [];
}

class ChangeUserModeEvent extends UserInfoEvent {
  final InfoModes mode;
  const ChangeUserModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}

class RegisterDataEvent extends UserInfoEvent {
  const RegisterDataEvent();

  Map<String, String> get toJson => {};

  @override
  List<Object?> get props => [];
}
