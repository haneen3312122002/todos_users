import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/core/features/job/service/jobs_service.dart';

final jobsServiceProvider = Provider<JobsService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final db = ref.read(firebaseFirestoreProvider);
  return JobsService(auth: auth, db: db);
});
