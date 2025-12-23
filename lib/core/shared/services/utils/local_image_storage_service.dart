import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class LocalImageStorageService {
  static const _avatarKey = 'local_avatar_bytes';
  static const _coverKey = 'local_cover_bytes';



  Future<void> saveAvatar(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final base64 = base64Encode(bytes);
    await prefs.setString(_avatarKey, base64);
  }

  Future<Uint8List?> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final base64 = prefs.getString(_avatarKey);
    if (base64 == null) return null;
    try {
      return base64Decode(base64);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarKey);
  }



  Future<void> saveCover(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final base64 = base64Encode(bytes);
    await prefs.setString(_coverKey, base64);
  }

  Future<Uint8List?> getCover() async {
    final prefs = await SharedPreferences.getInstance();
    final base64 = prefs.getString(_coverKey);
    if (base64 == null) return null;
    try {
      return base64Decode(base64);
    } catch (_) {
      return null;
    }
  }

  Future<void> clearCover() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_coverKey);
  }
}