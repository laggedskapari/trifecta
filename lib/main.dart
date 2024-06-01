import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trifecta/trifecta.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Trifecta(
      trifectaAuthenticationRepository: TrifectaAuthenticationRepositoryImplementation(),
    ),
  );
}
