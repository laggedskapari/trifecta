import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross/src/cross_tasklist_repository.dart';
import 'package:cross/src/entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cross/src/model/models.dart';
import 'package:uuid/uuid.dart';

class CrossTasklistRepositoryImplementation implements CrossTaskListRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _trifectaUserReference =
      FirebaseFirestore.instance.collection('trifectaUser');

  CrossTasklistRepositoryImplementation({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<CrossTaskList>> getAllTaskLists() {
    final crossTaskListsRef = _trifectaUserReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('taskLists');
    return crossTaskListsRef.snapshots().map((taskListsSnapshot) {
      return taskListsSnapshot.docs.map((doc) {
        Map<String, dynamic> taskListData = doc.data();
        return CrossTaskList.fromCrossTaskListEntity(
            CrossTaskListEntity.fromFirestoreDocument(taskListData));
      }).toList();
    });
  }

  @override
  Future<void> createNewTaskList({required String taskListTitle}) async {
    try {
      const uuid = Uuid();
      final newTaskListRef = _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc();
      final newTaskList = CrossTaskList(
          firebaseTaskListId: newTaskListRef.id,
          taskListId: uuid.v4(),
          taskListTitle: taskListTitle,
          createdOn: DateTime.now());
      await newTaskListRef
          .set(newTaskList.toCrossTaskListEntity().toFirestoreDocument());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> updateTaskListTitle({
    required String taskListTitle,
    required String firebaseTaskListId,
  }) async {
    try {
      await _trifectaUserReference
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('taskLists')
          .doc(firebaseTaskListId)
          .update({'taskListTitle': taskListTitle});
    } catch (e) {
      log(e.toString());
    }
  }

  @override 
  Future<void> deleteTaskList({required String firebaseTaskListId,}) async {
    try {
      await _trifectaUserReference.doc(_firebaseAuth.currentUser!.uid).collection('taskLists').doc(firebaseTaskListId).delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
