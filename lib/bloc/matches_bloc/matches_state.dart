part of 'matches_bloc.dart';

class PlayState extends Equatable {
  final MatchesViewType type;
  final BlocStatus groundStatus;
  final BlocStatus matchesStatus;
  final ShowData<Ground> grounds;

  const PlayState({
    required this.type,
    required this.grounds,
    required this.groundStatus,
    required this.matchesStatus,
  });

  factory PlayState.initial() => PlayState(
        type: MatchesViewType.grounds,
        grounds: ShowData.empty(),
        matchesStatus: BlocStatus.idle,
        groundStatus: BlocStatus.idle,
      );

  PlayState copyWith({
    MatchesViewType? type,
    ShowData<Ground>? grounds,
    BlocStatus? groundStatus,
    BlocStatus? matchesStatus,
    bool? forceNull,
  }) {
    return PlayState(
      type: type ?? this.type,
      grounds: grounds ?? this.grounds,
      matchesStatus: matchesStatus ?? this.groundStatus,
      groundStatus: groundStatus ?? this.groundStatus,
    );
  }

  @override
  List<Object?> get props => [type, matchesStatus, groundStatus];
}

enum MatchesViewType {
  grounds,
  active;

  @override
  String toString() {
    switch (this) {
      case MatchesViewType.grounds:
        return StringManger.ground;
      case MatchesViewType.active:
        return StringManger.active;
    }
  }

  IconData toIcon() {
    switch (this) {
      case MatchesViewType.grounds:
        return FontAwesomeIcons.mapLocationDot;
      case MatchesViewType.active:
        return FontAwesomeIcons.peopleGroup;
    }
  }
}
