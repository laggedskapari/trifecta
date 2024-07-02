import 'package:cross/cross_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/trifecta.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Trifecta(
      trifectaAuthenticationRepository: TrifectaAuthenticationRepositoryImplementation(),
      crossTaskListRepository: CrossTasklistRepositoryImplementation(),
      crossTaskRepository: CrossTaskRepositoryImplementation(),
      logsLogRepository: LogsLogRepositoryImplementation(),
      logsTaskRepository: LogsTaskRepositoryImplementation(),
      logRecordRepository: LogRecordRepositoryImplementation(),
    ),
  );
}
