import 'package:equatable/equatable.dart';

class FocusEntry extends Equatable {
  final DateTime focusInitDateTime;
  final double focusDuration;
  final bool isFocusBreak;

  const FocusEntry({
    required this.focusInitDateTime,
    required this.focusDuration,
    required this.isFocusBreak,
  });

  FocusEntryEntity toFocusEntryEntity() {
    return toFocusEntryEntity(
      focusInitDateTime: focusInitDateTime,
      focusDuration: focusDuration,
      isFocusBreak: isFocusBreak,
    );
  }

  static FocusEntry fromFocusEntryEntity(FocusEntryEntity entity) {
    return FocusEntry(
      focusDuration: entity.focusDuration,
      focusInitDateTime: entity.focusInitDateTime,
      isFocusBreak: entity.isFocusBreak,
    );
  }
}

