import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_details/providers/data_providers/get_user_address_provider.dart';

final getUserAddressViewModelProvider =
    AsyncNotifierProvider<GetUserAddressViewModel, AddressEntity?>(
      GetUserAddressViewModel.new,
    );

class GetUserAddressViewModel extends AsyncNotifier<AddressEntity?> {
  late final _useCase = ref.read(getUserAddressUseCaseProvider);

  @override
  FutureOr<AddressEntity?> build() async => null;

  Future<void> getUserAddress(int id) async {
    state = const AsyncLoading();
    try {
      final address = await _useCase.call(id);
      state = AsyncData(address);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clearAddress() => state = const AsyncData(null);
}