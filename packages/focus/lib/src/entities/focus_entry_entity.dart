import 'package:equatable/equatable.dart';

class FocusEntryEntity extends Equatable {
  final DateTime focusInitDateTime;
  final double focusDuration;
  final bool isFocusBreak;

  const FocusEntryEntity({
    required this.focusDuration,
    required this.focusInitDateTime,
    required this.isFocusBreak,
  });

  Map<String, Object?> toFirebaseDocument() {
    return {
      'focusDuration': focusDuration,
      'focusInitDateTime': focusInitDateTime,
      'isFocusBreak': isFocusBreak,
    };
  }

  static FocusEntryEntity fromFirebaseDocument(Map<String, dynamic> doc) {
    return FocusEntryEntity(
      focusInitDateTime: doc['focusInitDateTime'],
      focusDuration: doc['focusDuration'],
      isFocusBreak: doc['isFocusBreak'],
    );
  }

  @override 
  List<Object?> get props => [focusInitDateTime, focusDuration, isFocusBreak];
}
