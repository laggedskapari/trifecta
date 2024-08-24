import 'package:equatable/equatable.dart';

class FocusEntity extends Equatable {
  final double totalBreakTime;
  final double totalFocusTime;

  const FocusEntity({
    required this.totalBreakTime,
    required this.totalFocusTime,
  });

  Map<String, Object?> toFirebaseDocument() {
    return {
      'totalBreakTime': totalBreakTime,
      'totalFocusTime': totalFocusTime,
    };
  }

  static FocusEntity fromFirebaseDocument(Map<String, dynamic> doc) {
    return FocusEntity(
      totalBreakTime: doc['totalBreakTime'],
      totalFocusTime: doc['totalFocusTime'],
    );
  }

  @override
  List<Object?> get props => [totalBreakTime, totalFocusTime];
}
