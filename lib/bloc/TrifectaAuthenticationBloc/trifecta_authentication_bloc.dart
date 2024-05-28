import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

part 'trifecta_authentication_event.dart';
part 'trifecta_authentication_state.dart';

class TrifectaAuthenticationBloc
    extends Bloc<TrifectaAuthenticationEvent, TrifectaAuthenticationState> {
  final TrifectaAuthenticationRepository trifectaAuthenticationRepository;
  late final StreamSubscription<User?> _trifectaUserSubscription;

  TrifectaAuthenticationBloc({required this.trifectaAuthenticationRepository})
      : super(const TrifectaAuthenticationState.unknown()) {
    _trifectaUserSubscription = trifectaAuthenticationRepository
        .currentTrifectaUser
        .listen((currentTrifectaUser) {
      add(TrifectaAuthenticationUserChanged(currentTrifectaUser));
    });

    on<TrifectaAuthenticationUserChanged>((event, emit) {
      if (event.currentTrifectaUser != null) {
        emit(TrifectaAuthenticationState.authenticated(
          event.currentTrifectaUser!,
        ));
      } else {
        emit(
          const TrifectaAuthenticationState.unauthenticated(),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _trifectaUserSubscription.cancel();
    return super.close();
  }
}
