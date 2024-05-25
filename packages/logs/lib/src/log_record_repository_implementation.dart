import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/src/entity/entities.dart';
import 'package:log/src/log_record_repository.dart';
import 'package:log/src/model/models.dart';

class LogRecordRepositoryImplementation implements LogRecordRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUsers');

  LogRecordRepositoryImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<LogRecord>> getAllLogRecords({required String firebaseLogId}) {
    final logRecordRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('logs')
        .doc(firebaseLogId)
        .collection('records');
    return logRecordRef.snapshots().map((logRecordsSnapshot) {
      return logRecordsSnapshot.docs.map((doc) {
        Map<String, dynamic> logRecordData = doc.data();
        return LogRecord.fromLogRecordEntity(
            LogRecordEntity.fromFirebaseDocument(logRecordData));
      }).toList();
    });
  }

  @override
  Future<void> createNewLogRecord({required String firebaseLogId, required firebaseLogTaskId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLogRecord({required String firebaseLogId, required String firebaseLogRecordId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTaskFromLogRecord({required String firebaseLogId, required String firebaseLogRecordId, required String firebaseLogTaskId}) {
    throw UnimplementedError();
  }
}
