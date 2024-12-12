import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:final_projects/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/matches.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/play_repo.dart';
import '../../presentation/resources/string_manager.dart';
import '../status.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayState.initial()) {
    on<ChangeViewTypeEvent>(_changeViewTypeHandler);
    on<GetGroundsEvent>(_getGroundsEventHandler);
    on<GetProductsEvent>(_getProductsEventHandler);
    on<GetStartDataEvent>(_getStartDataHandler);

    add(const GetStartDataEvent());
  }
  final PlayRepository _repository = PlayRepository();

  Future<void> _changeViewTypeHandler(
      ChangeViewTypeEvent event, Emitter emit) async {
    emit(state.copyWith(type: event.type));
    if (event.type == MatchesViewType.grounds) {
      await _getGroundsFirstData(emit);
    } else if (event.type == MatchesViewType.store) {
      await _getProductData(emit);
    }
  }

  Future<void> _getStartDataHandler(GetStartDataEvent _, Emitter emit) async {
    emit(state.copyWith(groundStatus: BlocStatus.gettingData));
    await _getGroundsFirstData(emit);
  }

  Future<void> _getGroundsFirstData(Emitter emit) async {
    emit(state.copyWith(groundStatus: BlocStatus.gettingData));
    Either<Failure, List<Ground>> all =
        await _repository.getAllGrounds();
    all.fold(
        (_) => emit(state.copyWith(groundStatus: BlocStatus.error)),
        (data) => emit(state.copyWith(
              groundStatus: BlocStatus.getData,
              grounds: data,
            )));
  }

  void _getGroundsEventHandler(GetGroundsEvent _, Emitter emit) =>
      _getGroundsFirstData(emit);

  Future<void> _getProductData(Emitter emit) async {
    emit(state.copyWith(groundStatus: BlocStatus.gettingData));
    Either<Failure, List<Product>> all =
        await _repository.getAllProducts();
    all.fold(
        (_) => emit(state.copyWith(groundStatus: BlocStatus.error)),
        (data) => emit(state.copyWith(
              groundStatus: BlocStatus.getData,
              products: data,
            )));
  }

  void _getProductsEventHandler(GetProductsEvent _, Emitter emit) =>
      _getProductData(emit);
}
