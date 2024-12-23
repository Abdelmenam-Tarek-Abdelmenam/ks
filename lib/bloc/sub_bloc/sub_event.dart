part of 'sub_bloc.dart';

sealed class SubEvent extends Equatable {
  const SubEvent();
}


class GeSubEvent extends SubEvent {
  const GeSubEvent();

  @override
  List<Object?> get props => [];
}

class ChangeViewTypeEvent extends SubEvent {
  final SubViewType type ;
  const ChangeViewTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}
