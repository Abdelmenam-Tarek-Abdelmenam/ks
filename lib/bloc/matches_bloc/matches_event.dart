part of 'matches_bloc.dart';

abstract class PlayEvent extends Equatable {
  const PlayEvent();
  @override
  List<Object?> get props => [];
}

class ChangeViewTypeEvent extends PlayEvent {
  final MatchesViewType type;
  const ChangeViewTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}


class GetStartDataEvent extends PlayEvent {
  const GetStartDataEvent();
}

class GetGroundsEvent extends PlayEvent {
  const GetGroundsEvent();
}

class GetProductsEvent extends PlayEvent {
  const GetProductsEvent();
}



class RegisterGroundsEvent extends PlayEvent {
  final GroundRegister data;

  const RegisterGroundsEvent(this.data);

  @override
  List<Object> get props => [data.idCourt , data.dateRsvCourt,data.endRsvCourt, data.startRsvCourt];
}

class RegisterProductsEvent extends PlayEvent {
  final ProductRegister data;
  const RegisterProductsEvent(this.data);

  @override
  List<Object> get props => [data.idSub];
}
