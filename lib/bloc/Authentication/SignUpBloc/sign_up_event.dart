part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final TrifectaUser newUser;
  final String passkey;

  const SignUpRequired({required this.newUser, required this.passkey});
}
