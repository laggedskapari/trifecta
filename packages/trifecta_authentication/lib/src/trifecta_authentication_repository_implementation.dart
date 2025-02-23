import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class TrifectaAuthenticationRepositoryImplementation
    implements TrifectaAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final trifectaUserCollection =
      FirebaseFirestore.instance.collection('trifectaUsers');

  TrifectaAuthenticationRepositoryImplementation({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get currentTrifectaUser {
    return _firebaseAuth.authStateChanges().map((trifectaUser) {
      return trifectaUser;
    });
  }

  @override
  Future<void> signIn({
    required String emailAddress,
    required String passkey,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: passkey,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure(message: e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<TrifectaUser> signUp({
    required TrifectaUser trifectaUser,
    required String passkey,
  }) async {
    try {
      UserCredential newTrifectaCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: trifectaUser.emailAddress,
        password: passkey,
      );

      trifectaUser = trifectaUser.copyWith(
        trifectaFirebaseUID: newTrifectaCredential.user!.uid,
      );
      return trifectaUser;
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure(message: e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> setTrifectaUserData({required TrifectaUser trifectaUser}) async {
    try {
      await trifectaUserCollection
          .doc(trifectaUser.trifectaFirebaseUID)
          .set(trifectaUser.toTrifectaUserEntity().toFirebaseDocument());
    } on FirebaseException catch (e) {
      throw FirestoreFailure(message: e.code);
    } catch (_) {
      throw const FirestoreFailure();
    }
  }

  @override 
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
