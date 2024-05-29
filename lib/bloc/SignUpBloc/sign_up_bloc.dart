import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final TrifectaAuthenticationRepository _trifectaAuthenticationRepository;

  SignUpBloc({
    required TrifectaAuthenticationRepository trifectaAuthenticationRepository,
  })  : _trifectaAuthenticationRepository = trifectaAuthenticationRepository,
        super(const SignUpState.initial()) {
    on<SignUpRequired>((event, emit) async {
      emit(const SignUpState.processing());
      try {
        TrifectaUser newUser = await _trifectaAuthenticationRepository.signUp(
          trifectaUser: event.newUser,
          passkey: event.passkey,
        );
        await _trifectaAuthenticationRepository.setTrifectaUserData(
          trifectaUser: newUser,
        );
        emit(const SignUpState.success());
      } on FirebaseAuthException catch (e) {
        emit(SignUpState.failure(errorMessage: e.code));
      }
    });
  }
}
