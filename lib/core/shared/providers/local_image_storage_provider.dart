// lib/core/shared/providers/local_image_storage_provider.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalImageStorageState {
  final Map<String, Uint8List?> avatarByUser;
  final Map<String, Uint8List?> coverByUser;

  const LocalImageStorageState({
    this.avatarByUser = const {},
    this.coverByUser = const {},
  });

  LocalImageStorageState copyWith({
    Map<String, Uint8List?>? avatarByUser,
    Map<String, Uint8List?>? coverByUser,
  }) {
    return LocalImageStorageState(
      avatarByUser: avatarByUser ?? this.avatarByUser,
      coverByUser: coverByUser ?? this.coverByUser,
    );
  }

  Uint8List? avatarFor(String uid) => avatarByUser[uid];
  Uint8List? coverFor(String uid) => coverByUser[uid];
}

class LocalImageStorageNotifier extends StateNotifier<LocalImageStorageState> {
  LocalImageStorageNotifier() : super(const LocalImageStorageState()) {
    _loadInitial();
  }

  static const _avatarPrefix = 'local_avatar_bytes_'; // 👈 صار فيه uid بعده
  static const _coverPrefix = 'local_cover_bytes_';

  Future<void> _loadInitial() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final avatarMap = <String, Uint8List?>{};
    final coverMap = <String, Uint8List?>{};

    for (final key in keys) {
      if (key.startsWith(_avatarPrefix)) {
        final uid = key.substring(_avatarPrefix.length);
        final base64Str = prefs.getString(key);
        if (base64Str == null) continue;
        try {
          avatarMap[uid] = base64Decode(base64Str);
        } catch (_) {}
      } else if (key.startsWith(_coverPrefix)) {
        final uid = key.substring(_coverPrefix.length);
        final base64Str = prefs.getString(key);
        if (base64Str == null) continue;
        try {
          coverMap[uid] = base64Decode(base64Str);
        } catch (_) {}
      }
    }

    state = LocalImageStorageState(
      avatarByUser: avatarMap,
      coverByUser: coverMap,
    );
  }

  Future<void> saveAvatar({
    required String uid,
    required Uint8List bytes,
  }) async {
    final newAvatarMap = Map<String, Uint8List?>.from(state.avatarByUser)
      ..[uid] = bytes;

    state = state.copyWith(avatarByUser: newAvatarMap);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_avatarPrefix$uid',
      base64Encode(bytes),
    );
  }

  Future<void> saveCover({
    required String uid,
    required Uint8List bytes,
  }) async {
    final newCoverMap = Map<String, Uint8List?>.from(state.coverByUser)
      ..[uid] = bytes;

    state = state.copyWith(coverByUser: newCoverMap);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_coverPrefix$uid',
      base64Encode(bytes),
    );
  }

  Future<void> clearAvatar(String uid) async {
    final newAvatarMap = Map<String, Uint8List?>.from(state.avatarByUser)
      ..remove(uid);

    state = state.copyWith(avatarByUser: newAvatarMap);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_avatarPrefix$uid');
  }

  Future<void> clearCover(String uid) async {
    final newCoverMap = Map<String, Uint8List?>.from(state.coverByUser)
      ..remove(uid);

    state = state.copyWith(coverByUser: newCoverMap);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_coverPrefix$uid');
  }
}

final localImageStorageProvider =
    StateNotifierProvider<LocalImageStorageNotifier, LocalImageStorageState>(
  (ref) => LocalImageStorageNotifier(),
);
