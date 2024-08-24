import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus/focus_repository.dart';

class FocusRepoImplementation implements FocusRepo {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUsers');

  FocusRepoImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<FocusEntry>> getAllFocusEntries() {}

  @override
  Future<void> createNewFocusEntry({
    required DateTime focusInitDateTime,
    required double focusDuration,
  }) {}

  @override
  Future<void> deleteFocusEntry({
    required String firebaseFocusEntryId,
  }) {}
}
