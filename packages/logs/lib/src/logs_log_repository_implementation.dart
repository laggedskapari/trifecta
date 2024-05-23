import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/src/entity/logs_log_entity.dart';
import 'package:log/src/logs_log_repository.dart';
import 'package:log/src/model/logs_log.dart';
import 'package:uuid/uuid.dart';

class LogsLogRepositoryImplementation implements LogsLogRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUsers');

  LogsLogRepositoryImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<LogsLog>> getAllLogs() {
    final logsRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('logs');
    return logsRef.snapshots().map((logsSnapshot) {
      return logsSnapshot.docs.map((doc) {
        Map<String, dynamic> logsData = doc.data();
        return LogsLog.fromLogsLogEntity(
            LogsLogEntity.fromFirestoreDocument(logsData));
      }).toList();
    });
  }

  @override
  Future<void> createNewLogsLog(
      {required String logTitle, required int logDuration}) async {
    try {
      const uuid = Uuid();
      final today = DateTime.now();
      final endDate = today.add(
        Duration(
          days: logDuration,
        ),
      );
      final newLogsLogRef = await _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('logs')
          .doc();
      final LogsLog newLog = LogsLog(
        logEndDate: endDate,
        logCompletedOn: endDate,
        firebaseLogId: newLogsLogRef.id,
        logId: uuid.v4(),
        logTitle: logTitle,
        logCreatedOn: today,
        logDuration: logDuration,
        logInitDate: today,
      );
      await newLogsLogRef.set(newLog.toLogsLogEntity().toFirestoreDocument());
    } catch (e) {
      log(e.toString());
    }
  }

  @override 
  Future<void> deleteLogsLog({required String firebaseLogId,}) async {
    try {
      await _trifectaUserReference.doc(_firebaseAuth.currentUser!.uid).collection('logs').doc(firebaseLogId).delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
