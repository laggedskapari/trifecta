part of 'trifecta_authentication_bloc.dart';

enum TrifectaAuthenticationStatus { authenticated, unauthenticated, unknown }

final class TrifectaAuthenticationState extends Equatable {
  final TrifectaAuthenticationStatus status;
  final User? currentTrifectaUser;

  const TrifectaAuthenticationState._({
    this.status = TrifectaAuthenticationStatus.unknown,
    this.currentTrifectaUser,
  });
  const TrifectaAuthenticationState.unknown() : this._();
  const TrifectaAuthenticationState.authenticated(User currentTrifectaUser)
      : this._(
          currentTrifectaUser: currentTrifectaUser,
          status: TrifectaAuthenticationStatus.authenticated,
        );
  const TrifectaAuthenticationState.unauthenticated()
      : this._(status: TrifectaAuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, currentTrifectaUser];
}
