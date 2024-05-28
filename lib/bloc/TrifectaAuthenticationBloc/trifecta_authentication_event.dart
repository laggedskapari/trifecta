part of 'trifecta_authentication_bloc.dart';

sealed class TrifectaAuthenticationEvent extends Equatable {
  const TrifectaAuthenticationEvent();

  @override 
  List<Object?> get props => [];
}

class TrifectaAuthenticationUserChanged extends TrifectaAuthenticationEvent{
  final User? currentTrifectaUser;
  
  const TrifectaAuthenticationUserChanged(this.currentTrifectaUser);

  @override 
  List<Object?> get props => [currentTrifectaUser];
}
