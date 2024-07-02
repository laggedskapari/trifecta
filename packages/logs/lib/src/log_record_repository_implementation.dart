import 'dart:developer';

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
        .collection('logRecords');
    return logRecordRef.snapshots().map((logRecordsSnapshot) {
      return logRecordsSnapshot.docs.map((doc) {
        Map<String, dynamic> logRecordData = doc.data();
        return LogRecord.fromLogRecordEntity(
            LogRecordEntity.fromFirebaseDocument(logRecordData));
      }).toList();
    });
  }

  @override
  Future<LogRecord> getTodayLogRecord({required String firebaseLogId}) {
    final today = DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString();
    final todayLogRecordRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('logs')
        .doc(firebaseLogId)
        .collection('logRecords')
        .doc(today);
    return todayLogRecordRef.get().then((logRecordSnapshot) {
      return LogRecord.fromLogRecordEntity(LogRecordEntity.fromFirebaseDocument(logRecordSnapshot.data()));
    });
 }

  @override
  Future<void> createNewLogRecord({
    required String firebaseLogId,
    required String firebaseLogTaskId,
    required String logRecordDate,
  }) async {
    try {
      final String today = DateTime.now().day.toString() +
          DateTime.now().month.toString() +
          DateTime.now().year.toString();
      final newLogTaskRecordRef = _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('logs')
          .doc(firebaseLogId)
          .collection('logRecords')
          .doc(today);
      final newLogTaskRecord = LogRecord(
        logRecordDate: DateTime.now(),
        logRecordTasks: [firebaseLogTaskId],
      );

      await newLogTaskRecordRef
          .set(newLogTaskRecord.toLogRecordEntity().toFirebaseDocument());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<bool> isLogTaskCompletedToday({
    required String firebaseLogId,
  }) async {
    final String today = DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString();
    final logRecordRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('logs')
        .doc(firebaseLogId)
        .collection('logRecords')
        .doc(today);

    bool isCompleted = false;
    await logRecordRef.get().then((doc) {
      doc.exists ? isCompleted = true : isCompleted = false;
    });
    return isCompleted;
  }

  @override
  Future<void> deleteLogRecord({
    required String firebaseLogId,
    required String firebaseLogRecordId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeTaskFromLogRecord({
    required String firebaseLogId,
    required String firebaseLogRecordId,
    required String firebaseLogTaskId,
  }) {
    throw UnimplementedError();
  }
}
