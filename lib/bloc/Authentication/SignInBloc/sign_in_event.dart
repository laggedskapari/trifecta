part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequired extends SignInEvent {
  final String emailAddress;
  final String passkey;

  const SignInRequired({
    required this.emailAddress,
    required this.passkey,
  });
}

class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}
