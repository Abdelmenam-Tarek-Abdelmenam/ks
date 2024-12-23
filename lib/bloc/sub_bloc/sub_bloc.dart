import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:final_projects/domain_layer/repository_implementer/sub_repo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain_layer/repository_implementer/error_state.dart';
import '../status.dart';

part 'sub_event.dart';
part 'sub_state.dart';

class SubBloc extends Bloc<SubEvent, SubState> {
  SubBloc() : super(SubState.initial()) {
    on<GeSubEvent>(_getSubDataHandler);
    on<ChangeViewTypeEvent>(_changeViewTypeHandler);

    add(const GeSubEvent());
  }

  final SubRepository _repository = SubRepository();

  void _changeViewTypeHandler(
      ChangeViewTypeEvent event, Emitter emit) {
    emit(state.copyWith(type: event.type));
  }

  Future<void> _getSubDataHandler(GeSubEvent event, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));
    Either<Failure, SubData> all = await _repository.getAllSubs();

    all.fold(
        (_) => emit(state.copyWith(status: BlocStatus.error)),
        (data) => emit(state.copyWith(
              status: BlocStatus.getData,
              data: data,
            )));
  }
}
