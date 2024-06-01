import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final TrifectaAuthenticationRepository _trifectaAuthenticationRepository;

  SignInBloc({
    required TrifectaAuthenticationRepository trifectaAuthenticationRepository,
  })  : _trifectaAuthenticationRepository = trifectaAuthenticationRepository,
        super(const SignInState.initial()) {
    on<SignInRequired>((event, emit) async {
      emit(const SignInState.processing());
      try {
        await _trifectaAuthenticationRepository.signIn(
            emailAddress: event.emailAddress, passkey: event.passkey);
      } on FirebaseAuthException catch (e) {
        emit(SignInState.failure(message: e.code));
      }
    });
    on<SignOutRequired>((event, emit) async {
      try {
        await _trifectaAuthenticationRepository.logOut();
      } on FirebaseAuthException catch (e) {
        emit(SignInState.failure(message: e.code));
      }
    });
  }
}
