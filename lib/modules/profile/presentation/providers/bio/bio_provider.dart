import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/profile/get_profile_stream_provider.dart';

final bioProvider = Provider<String>((ref) {
  final profileAsync = ref.watch(profileStreamProvider);
  return profileAsync.maybeWhen(
    data: (profile) => profile?.bio ?? '',
    orElse: () => '',
  );
});