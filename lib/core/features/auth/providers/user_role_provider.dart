import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/data/remote/firebase/providers/firebase_providers.dart';
import 'package:notes_tasks/core/shared/enums/role.dart';

final userRoleProvider = FutureProvider<UserRole>((ref) async {
  final auth = ref.watch(firebaseAuthProvider);
  final db = ref.watch(firebaseFirestoreProvider);

  final user = auth.currentUser;
  if (user == null) return UserRole.client;

  final doc = await db.collection('users').doc(user.uid).get();
  if (!doc.exists) return UserRole.client;

  final data = doc.data();
  if (data == null) return UserRole.client;

  final rawRole = data['role'] as String?;
  return parseUserRole(rawRole);
});
