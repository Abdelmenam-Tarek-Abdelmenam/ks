part of 'sub_bloc.dart';

class SubState extends Equatable {
  final BlocStatus status;
  final SubViewType type;
  final SubData data;

  const SubState({required this.status, required this.type , required this.data});

  factory SubState.initial() =>
       SubState(status: BlocStatus.idle, type: SubViewType.talents, data : SubData.empty());

  SubState copyWith({BlocStatus? status, SubViewType? type, SubData? data}) =>
      SubState(status: status ?? this.status, type: type ?? this.type , data: data??this.data);

  @override
  List<Object?> get props => [status, type];
}

enum SubViewType {
  talents,
  champs;

  @override
  String toString() {
    switch (this) {
      case SubViewType.talents:
        return 'Talents Academy';
      case SubViewType.champs:
        return 'البطولات';
    }
  }

  IconData toIcon() {
    switch (this) {
      case SubViewType.talents:
        return FontAwesomeIcons.futbol;
      case SubViewType.champs:
        return FontAwesomeIcons.rankingStar;
    }
  }
}
