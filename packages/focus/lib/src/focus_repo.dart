import 'package:focus/focus_repository.dart';

abstract class FocusRepo {
  Stream<List<FocusEntry>> getAllFocusEntries();

  Future<void> createNewFocusEntry({
    required double focusDuration,
    required DateTime focusInitDateTime,
  });

  Future<void> deleteFocusEntry({
    required String firebaseFocusEntryId,
  });
}
