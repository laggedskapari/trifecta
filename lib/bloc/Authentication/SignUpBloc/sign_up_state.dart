part of 'sign_up_bloc.dart';

enum SignUpStatus { inital, success, failure, processing }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState._({
    this.status = SignUpStatus.inital,
    this.errorMessage,
  });

  const SignUpState.initial() : this._();
  const SignUpState.success() : this._();
  const SignUpState.failure({
    required String errorMessage,
  }) : this._(errorMessage: errorMessage);
  const SignUpState.processing() : this._();

  @override
  List<Object?> get props => [status, errorMessage];
}
