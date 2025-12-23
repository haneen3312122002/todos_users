import 'package:flutter_riverpod/legacy.dart';

final expandableTextStateProvider =
    StateProvider.autoDispose.family<bool, String>((ref, id) {
  return false; // false = مختصر (سطرين), true = كامل
});