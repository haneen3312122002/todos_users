import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_list/providers/data_providers/get_basic_users_provider.dart';

final getBasicUsersViewModelProvider =
    AsyncNotifierProvider<GetBasicUsersViewModel, List<UserEntity>>(
      GetBasicUsersViewModel.new,
    );

class GetBasicUsersViewModel extends AsyncNotifier<List<UserEntity>> {
  late final _useCase = ref.read(getBasicUsersUseCaseProvider);

  @override
  FutureOr<List<UserEntity>> build() async {
    final users = await _useCase.call();
    return users;
  }

  Future<void> fetchUsers() async {
    state = const AsyncLoading();
    try {
      final users = await _useCase.call();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refreshUsers() async {
    state = const AsyncLoading();
    try {
      final users = await _useCase.call();
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clearUsers() => state = const AsyncData([]);
}