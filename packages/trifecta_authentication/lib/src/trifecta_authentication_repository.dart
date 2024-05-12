import 'package:firebase_auth/firebase_auth.dart';
import 'package:trifecta_authentication/src/models/models.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

abstract class TrifectaAuthenticationRepository {
  Stream<User?> get currentTrifectaUser;
  Future<TrifectaUser> signUp({
    required TrifectaUser trifectaUser,
    required String passkey,
  });
  Future<void> signIn({
    required String emailAddress,
    required String passkey,
  });
  Future<void> setTrifectaUserData({required TrifectaUser trifectaUser});
  Future<void> logOut();
}

class FirestoreFailure implements Exception {
  final String message;

  const FirestoreFailure({
    this.message = 'An unknown error occured.',
  });

  factory FirestoreFailure.fromCode(String code) {
    switch (code) {
      case 'Aborted':
        return FirestoreFailure(
          message: 'Operation was aborted.',
        );
      case 'AlreadyExists':
        return const FirestoreFailure(
          message: 'Document already exists.',
        );
      case 'Cancelled':
        return const FirestoreFailure(
          message: 'Operation was cancelled.',
        );
      case 'DataLoss':
        return const FirestoreFailure(
          message: 'Unrecoverable data loss occured',
        );
      case 'DeadlineExceeded':
        return const FirestoreFailure(
          message: 'Deadline Expired.',
        );
      case 'FailedPrecondition':
        return const FirestoreFailure(
          message: 'Operation is rejected.',
        );
      case 'Internal':
        return const FirestoreFailure(
          message: 'Internal error.',
        );
      case 'InvalidArgument':
        return const FirestoreFailure(
          message: 'Invalid Argument.',
        );
      case 'NotFound':
        return const FirestoreFailure(
          message: 'Document was not found.',
        );
      case 'OutOfRange':
        return const FirestoreFailure(
          message: 'Out of valid range.',
        );
      case 'PermissionDenied':
        return const FirestoreFailure(
          message:
              'You do not have valid authentication credential for the operation.',
        );
      case 'ResourceExhausted':
        return const FirestoreFailure(
          message: 'Resources has been exhausted.',
        );
      case 'Unauthenticated':
        return const FirestoreFailure(
          message:
              'You do not have valid authentication credential for the operation.',
        );
      case 'Unavailable':
        return const FirestoreFailure(
          message: 'Service is currently unavailable.',
        );
      case 'Unimplemented':
        return const FirestoreFailure(
          message: 'Operation is not implemented or not supported/enabled.',
        );
      default:
        return const FirestoreFailure();
    }
  }
}

class SignInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignInWithEmailAndPasswordFailure({
    this.message = 'An Unknow exception occured.',
  });

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Account exists with different credentials.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          message: 'User has been disabled. Please contact support.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Incorrect password.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  const SignUpWithEmailAndPasswordFailure({
    this.message = 'An Unknown exception occured.',
  });

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'User has been disabled. Please reach out to support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Operation not allowed. Please contact support',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Please enter a stronger password',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
