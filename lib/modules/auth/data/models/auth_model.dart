// lib/modules/auth/data/models/auth_model.dart

import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.uid,
    super.email,
    super.displayName,
    super.photoUrl,
    super.isEmailVerified = false,
    super.role,
    super.createdAt,
  });

  /// Firestore / API
  factory AuthModel.fromMap(
    Map<String, dynamic> map, {
    required String uid,
  }) {
    return AuthModel(
      uid: uid,
      email: map['email'] as String?,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isEmailVerified: (map['isEmailVerified'] as bool?) ?? false,
      role: map['role'] as String?,
      createdAt: _parseDate(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  /// Helper لتوحيد الـ parsing (يدعم String/DateTime/Firestore Timestamp بدون import مباشر)
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    if (value is DateTime) return value;

    if (value is String) {
      return DateTime.tryParse(value);
    }

    // Firestore Timestamp (بدون dependency على cloud_firestore داخل domain)
    // Timestamp عنده toDate()
    try {
      final toDate = value.toDate as DateTime Function();
      return toDate();
    } catch (_) {
      return null;
    }
  }

  AuthModel copyWithModel({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isEmailVerified,
    String? role,
    DateTime? createdAt,
  }) {
    return AuthModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
