import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/data_sources/pref_repository.dart';
import '../../data/models/app_user.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';
import '../../presentation/resources/string_manager.dart';
import '../../presentation/shared/toast_helper.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthBloc extends Bloc<AuthStatusEvent, AuthStates> {
  final SigningRepository _authRepository = SigningRepository();

  AuthBloc(AppUser? appUser) : super(AuthStates.initial(appUser)) {
    if (appUser != null) user = appUser;

    on<SignUpInUsingEmailEvent>(_signUpUsingEmailHandler);
    on<LoginInUsingEmailEvent>(_loginUsingEmailHandler);
    on<ChangeAuthModeEvent>(_changeModeHandler);
  }

  bool get loading => [AuthStatus.submittingEmail, AuthStatus.submittingGoogle]
      .contains(state.status);

  static AppUser user = AppUser.empty();

  void _changeModeHandler(ChangeAuthModeEvent event, Emitter<AuthStates> emit) {
    emit(state.copyWith(mode: event.mode, status: AuthStatus.initial));
  }



  Future<void> _loginUsingEmailHandler(
    LoginInUsingEmailEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;
    emit(state.copyWith(status: AuthStatus.submittingEmail));
    Either<Failure, AppUser> value = await _authRepository
        .signInWithEmailAndPassword(event.email, event.password);

    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (completeUser) {
      user = completeUser;
      if (!completeUser.isEmpty) {
        PreferenceRepository.putData(
            key: PreferenceKey.userData, value: completeUser.toJson);

        emit(state.copyWith(
            status: AuthStatus.successLogIn,
          ));
      } else {
        emit(state.copyWith(status: AuthStatus.successSignUp));
      }
    });
  }

  Future<void> _signUpUsingEmailHandler(
    SignUpInUsingEmailEvent event,
    Emitter<AuthStates> emit,
  ) async {
    if (loading) return;

    emit(state.copyWith(status: AuthStatus.submittingEmail));
    Either<Failure, AppUser> value = await _authRepository
        .signUpWithEmailAndPassword(event.email, event.password);
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: AuthStatus.error));
    }, (appUser) {
      user = appUser;
      emit(state.copyWith(status: AuthStatus.successSignUp));
    });
  }

}
