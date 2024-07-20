import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross/cross_repository.dart';
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
    print("This is called");
    final crossTaskRef = _trifectaUserRef
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('taskLists')
        .doc(firebaseTaskListId)
        .collection('tasks');
    return crossTaskRef.snapshots().map((tasksSnapshot) {
      return tasksSnapshot.docs.map((doc) {
        Map<String, dynamic> crossTaskData = doc.data();
        print(crossTaskData);
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

      final taskListRef = _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId);
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
        firebaseTaskListId: firebaseTaskListId,
        firstAlert: DateTime.now(),
        secondAlert: DateTime.now(),
        completedOn: DateTime.now(),
      );

      await newTaskRef
          .set(newTask.toCrossTaskEntity().toFirestoreDocument())
          .then((value) => taskListRef.update({'totalTasks': FieldValue.increment(1)}));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required String taskTitle,
    required DateTime? firstAlert,
    required DateTime? secondAlert,
  }) async {
    try {
      await _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId)
          .update({
        'taskTitle': taskTitle,
        'firstAlert': firstAlert,
        'secondAlert': secondAlert,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateTaskCompletion({
    required String firebaseTaskId,
    required String firebaseTaskListId,
    required bool isCompleted,
  }) async {
    final taskRef = _trifectaUserRef
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('taskLists')
        .doc(firebaseTaskListId)
        .collection('tasks')
        .doc(firebaseTaskId);
    final taskListRef = _trifectaUserRef
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('taskLists')
        .doc(firebaseTaskListId);

    try {
      if (isCompleted) {
        FirebaseFirestore.instance.runTransaction((transac) async {
          final dataSnapshot = await transac.get(taskListRef);
          final newTotalCompletedTasks =
              await dataSnapshot.get("totalCompletedTasks") + 1;

          transac.delete(taskRef);
          transac.update(taskListRef, {
            "totalCompletedTasks": newTotalCompletedTasks,
          });
        });
      } else {
        FirebaseFirestore.instance.runTransaction((transac) async {
          final dataSnapshot = await transac.get(taskListRef);
          final newTotalCompletedTasks =
              await dataSnapshot.get("totalCompletedTasks") - 1;

          transac.delete(taskRef);
          transac.update(taskListRef, {
            "totalCompletedTasks": newTotalCompletedTasks,
          });
        });
      }
    } catch (e) {
      log(e.toString());
      rethrow;
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
      rethrow;
    }
  }

  @override
  Future<void> deleteTask({
    required String firebaseTaskListId,
    required String firebaseTaskId,
  }) async {
    try {
      final taskRef = _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .collection('tasks')
          .doc(firebaseTaskId);

      final taskListRef = _trifectaUserRef
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId);

      FirebaseFirestore.instance.runTransaction((transac) async {
        final dataSnapshot = await transac.get(taskListRef);
        final newTotalTasks = await dataSnapshot.get("totalTasks") - 1;

        transac.delete(taskRef);
        transac.update(taskListRef, {
          "totalTasks": newTotalTasks,
        });
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
