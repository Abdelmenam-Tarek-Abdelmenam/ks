part of "user_info_status_bloc.dart";

enum InfoStatus {
  initial,
  changingDataInput,
  loading,
  error,
  done,
}

enum InfoModes { personal, sports, parents }

extension Names on InfoModes {
  String get getName {
    switch (this) {
      case InfoModes.personal:
        return "معلومات شخصيه";
      case InfoModes.sports:
        return "المواصفات البدنيه";
      case InfoModes.parents:
        return "معلومات ولي الامر";
    }
  }
}

class InfoStates extends Equatable {
  final InfoStatus status;
  final InfoModes mode;

  const InfoStates({
    required this.status,
    required this.mode,
  });

  factory InfoStates.initial() {
    return const InfoStates(
      status: InfoStatus.initial,
      mode: InfoModes.personal,
    );
  }

  @override
  List<Object?> get props => [status, mode];

  InfoStates copyWith({
    InfoStatus? status,
    InfoModes? mode,
  }) {
    return InfoStates(
      status: status ?? this.status,
      mode: mode ?? this.mode,
    );
  }
}
