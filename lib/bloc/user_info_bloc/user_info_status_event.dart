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
class ChangeUserEvent extends UserInfoEvent {
  final bool isActive;
  const ChangeUserEvent(this.isActive);

  @override
  List<Object?> get props => [isActive];
}

class RegisterDataEvent extends UserInfoEvent {
  final AppUser temp;
  final bool isUpdate;
  const RegisterDataEvent(this.temp, this.isUpdate);

  Map<String, String> get toJson {
    Map<String, String> d =
        temp.toJson.map((k, v) => MapEntry(k, v.toString()));
    d.addAll({'mon3m_flag': isUpdate ? '2' : '1'});
    return d;
  }

  @override
  List<Object?> get props => [];
}
