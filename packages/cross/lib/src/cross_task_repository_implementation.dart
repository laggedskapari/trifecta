import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross/src/cross_task_repository.dart';
import 'package:cross/src/entities/cross_task_entity.dart';
import 'package:cross/src/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CrossTaskRepositoryImplementation implements CrossTaskRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserRef =
      FirebaseFirestore.instance.collection('trifectaUsers');

  CrossTaskRepositoryImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<CrossTask>> getAllTasks({required String firebaseTaskListId}) {
    final crossTaskRef = _trifectaUserRef
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('taskLists')
        .doc(firebaseTaskListId)
        .collection('tasks');
    return crossTaskRef.snapshots().map((tasksSnanpshot) {
      return tasksSnanpshot.docs.map((doc) {
        Map<String, dynamic> crossTaskData = doc.data();
        return CrossTask.fromCrossTaskEntity(
            CrossTaskEntity.fromFirestoreDocument(crossTaskData));
      }).toList();
    });
  }

  @override
  Future<void> createNewCrossTask({
    required String firebaseTaskListId,
    required String taskTitle,
  }) async {
    try {
      const uuid = Uuid();
      final newTaskRef = _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc();
      final newTask = CrossTask(
          firebaseTaskId: newTaskRef.id,
          taskId: uuid.v4(),
          taskTitle: taskTitle,
          createdOn: DateTime.now(),
          firebaseTaskListId: firebaseTaskListId);
      await newTaskRef.set(newTask.toCrossTaskEntity().toFirestoreDocument());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateTaskTitle({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required String taskTitle,
  }) async {
    try {
      await _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId)
          .update({'taskTitle': taskTitle});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateTaskCompletion({
    required String firebaseTaskId,
    required String firebaseTaskListId,
    required bool isCompleted,
  }) async {
    try {
      await _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId)
          .update({
        'isCompleted': isCompleted,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateTaskImportance({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required bool isImportant,
  }) async {
    try {
      await _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId)
          .update({
        'isImportant': isImportant,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> deleteTask({
    required String firebaseTaskListId,
    required String firebaseTaskId,
  }) async {
    try {
      await _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
