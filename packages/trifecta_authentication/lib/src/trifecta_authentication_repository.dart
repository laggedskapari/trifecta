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
