import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:log/src/entity/log_task_entity.dart';
import 'package:log/src/logs_task_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log/src/model/models.dart';

class LogsTaskRepositoryImplementation implements LogsTaskRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUsers');

  LogsTaskRepositoryImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<LogTask>> getAllLogTasks({
    required String firebaseLogId,
  }) {
    final logTasksRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('logs')
        .doc(firebaseLogId)
        .collection('logTasks');
    return logTasksRef.snapshots().map((logTasksSnapshot) {
      return logTasksSnapshot.docs.map((doc) {
        Map<String, dynamic> logTasksData = doc.data();
        return LogTask.fromLogTaskEntity(
            LogTaskEntity.fromFirestoreDocument(logTasksData));
      }).toList();
    });
  }

  
  // @override
  // Future<void> createNewLogTasks({
  //   required String firebaseLogId,
  //   required List<LogTask> logTasks,
  // }) async {
  //   try {
  //     final newLogTaskWriteBatch = FirebaseFirestore.instance.batch();
  //     logTasks.forEach((logTask) {
  //       final newLogTaskRef = _trifectaUserReference
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .collection('logs')
  //           .doc(firebaseLogId)
  //           .collection('logTasks')
  //           .doc();
  //       newLogTaskWriteBatch.set(
  //         newLogTaskRef,
  //         logTask.toLogTaskEntity().toFirestoreDocument(),
  //       );
  //     });
  //     await newLogTaskWriteBatch.commit();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
