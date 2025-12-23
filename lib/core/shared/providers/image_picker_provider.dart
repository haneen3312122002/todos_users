import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/shared/services/utils/image_picker_service.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>(
  (ref) => ImagePickerService(),
);