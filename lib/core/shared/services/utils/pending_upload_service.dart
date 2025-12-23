import 'dart:typed_data';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PendingUploadStorageService {
  static const String _keyAvatar = 'pending_avatar_upload';
  static const String _keyCover = 'pending_cover_upload';

  Future<void> savePendingAvatar(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAvatar, base64Encode(bytes));
  }

  Future<void> savePendingCover(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCover, base64Encode(bytes));
  }

  Future<Uint8List?> getPendingAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keyAvatar);
    if (str == null) return null;
    return base64Decode(str);
  }

  Future<Uint8List?> getPendingCover() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keyCover);
    if (str == null) return null;
    return base64Decode(str);
  }

  Future<void> clearPendingAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAvatar);
  }

  Future<void> clearPendingCover() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCover);
  }
}