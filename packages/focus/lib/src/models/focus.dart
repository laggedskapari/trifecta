import 'package:equatable/equatable.dart';

class Focus extends Equatable {
  final double totalFocusTime;
  final double totalBreakTime;

  const Focus({
    this.totalFocusTime = 0.0,
    this.totalBreakTime = 0.0,
  });

  FocusEntity toFocusEntity() {
    return FocusEntity(
      totalFocusTime: totalFocusTime,
      totalBreakTime: totalBreakTime,
    );
  }

  static Focus fromFocusEntity(FocusEntity entity) {
    return Focus(
      totalFocusTime: entity.totalFocusTime,
      totalBreakTime: entity.totalBreakTime,
    );
  }

  @override
  List<Object?> get props => [totalBreakTime, totalFocusTime];
}
