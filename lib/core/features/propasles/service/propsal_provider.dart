import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/core/features/propasles/service/proposal_service.dart';

final proposalsServiceProvider = Provider<ProposalsService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final db = ref.read(firebaseFirestoreProvider);
  return ProposalsService(auth: auth, db: db);
});
