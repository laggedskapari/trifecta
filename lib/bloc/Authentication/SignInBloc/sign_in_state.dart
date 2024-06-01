part of 'sign_in_bloc.dart';

enum SignInStatus { intial, success, failure, processing }

class SignInState extends Equatable {
  final SignInStatus status;
  final String? message;

  const SignInState._({this.status = SignInStatus.intial, this.message});
  
  const SignInState.initial() : this._();
  const SignInState.success() : this._();
  const SignInState.failure({required String message}) : this._(message: message);
  const SignInState.processing() : this._();

  @override 
  List<Object?> get props => [status, message];
}
