import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/logs_repository.dart';
import 'package:uuid/uuid.dart';

class LogsLogRepositoryImplementation implements LogsLogRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUsers');
  final _trifectaFirestore = FirebaseFirestore.instance;

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
  Future<void> createNewLogsLog({
    required String logTitle,
    required int logDuration,
    required List<LogTask> logTasks,
  }) async {
    if (logDuration < 366 && logTasks.length < 6) {
      try {
        const uuid = Uuid();
        final today = DateTime.now();
        final endDate = today.add(
          Duration(
            days: logDuration,
          ),
        );
        final newLogsLogRef = _trifectaUserReference
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

        createLogTasks(newLogsLogRef: newLogsLogRef, logTasks: logTasks);
      } catch (e) {
        log(e.toString());
        throw e.toString();
      }
    }
    throw 'Log tasks or log duration exceeded the limit.';
  }

  void createLogTasks({
    required DocumentReference newLogsLogRef,
    required List<LogTask> logTasks,
  }) async {
    try {
      final logTasksBatch = _trifectaFirestore.batch();
      for (var logTask in logTasks) {
        final newLogTaskRef = newLogsLogRef.collection('logTasks').doc();
        final newLogTask = LogTask(
            logTaskTitle: logTask.logTaskTitle,
            firebaseLogTaskId: newLogTaskRef.id);
        logTasksBatch.set(
          newLogTaskRef,
          newLogTask.toLogTaskEntity().toFirestoreDocument(),
        );
      }
      await logTasksBatch.commit();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteLogsLog({
    required String firebaseLogId,
  }) async {
    try {
      await _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('logs')
          .doc(firebaseLogId)
          .delete();
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<void> updateLogsLogSuccess({
    required String firebaseLogId,
    required bool isSuccess,
  }) async {
    try {
      await _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('logs')
          .doc(firebaseLogId)
          .update({
        'isSuccess': isSuccess,
      });
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<void> updateSuccessRate({
    required String firebaseLogId,
    required double successRate,
  }) async {
    try {
      await _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('logs')
          .doc(firebaseLogId)
          .update({
        'successRate': successRate,
      });
    } catch (e) {
      log(e.toString());
      throw e.toString();
    }
  }
}
