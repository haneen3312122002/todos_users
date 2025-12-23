import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// لو بدك الكيان نفسه
// موديل الجوب (تأكد إنك عامله)

class ProfileService {
  final fb.FirebaseAuth auth;
  final FirebaseFirestore db;
  final FirebaseStorage storage;

  ProfileService({
    required this.auth,
    required this.db,
    required this.storage,
  });

  // =============================
  // Helpers
  // =============================

  fb.User? get currentUser => auth.currentUser;

  // user doc:
  DocumentReference<Map<String, dynamic>> _userDoc(String uid) {
    return db.collection('users').doc(uid);
  }

  // experiences subcollection:
  CollectionReference<Map<String, dynamic>> _experiencesCol(String uid) {
    return _userDoc(uid).collection('experiences');
  }

  // projects subcollection:
  CollectionReference<Map<String, dynamic>> _projectsCol(String uid) {
    return _userDoc(uid).collection('projects');
  }

  // jobs subcollection:

  // =============================
  // PROFILE DATA
  // =============================

  Future<Map<String, dynamic>?> getProfile() async {
    final user = currentUser;
    if (user == null) return null;

    final doc = await _userDoc(user.uid).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    return {
      'uid': user.uid,
      'name': data['name'] ?? user.displayName,
      'email': data['email'] ?? user.email,
      'photoUrl': data['photoUrl'],
      'coverUrl': data['coverUrl'],
      'createdAt': data['createdAt'],
      'role': data['role'],
      'skills': data['skills'],
      'bio': data['bio'],
    };
  }

  // =============================
  // PROFILE IMAGES
  // =============================

  Future<String> uploadProfileImage(Uint8List bytes) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final ref =
        storage.ref().child('users').child(user.uid).child('profile.jpg');

    await ref.putData(bytes);
    final url = await ref.getDownloadURL();

    // save the url:
    await _userDoc(user.uid).update({'photoUrl': url});
    await user.updatePhotoURL(url);

    return url;
  }

  Future<String> uploadCoverImage(Uint8List bytes) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final ref = storage.ref().child('users').child(user.uid).child('cover.jpg');

    await ref.putData(bytes);
    final url = await ref.getDownloadURL();

    await _userDoc(user.uid).update({'coverUrl': url});

    return url;
  }

  // =============================
  // NAME & EMAIL
  // =============================

  Future<void> updateName(String name) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    if (name.isEmpty) return;

    await user.updateDisplayName(name);

    await _userDoc(user.uid).update({
      'name': name,
    });
  }

  Future<void> updateEmail(String email) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    if (email.isEmpty || email == user.email) return;

    // send verify msg :
    await user.verifyBeforeUpdateEmail(email);

    await _userDoc(user.uid).update({
      'email': email,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchProfile() {
    final user = currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _userDoc(user.uid).snapshots();
  }

  // =============================
  // SKILLS MANAGEMENT
  // =============================

  Future<void> addSkill(String skill) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final trimmed = skill.trim();
    if (trimmed.isEmpty) return;

    await _userDoc(user.uid).update({
      'skills': FieldValue.arrayUnion([trimmed]),
    });
  }

  Future<void> removeSkill(String skill) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final trimmed = skill.trim();
    if (trimmed.isEmpty) return;

    await _userDoc(user.uid).update({
      'skills': FieldValue.arrayRemove([trimmed]),
    });
  }

  Future<void> setSkills(List<String> skills) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final cleaned = skills
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList(); // إزالة المكررات

    await _userDoc(user.uid).update({
      'skills': cleaned,
    });
  }

  // =============================
  // EXPERIENCES MANAGEMENT
  // =============================

  Future<String> addExperience({
    required String title,
    required String company,
    DateTime? startDate,
    DateTime? endDate,
    required String location,
    required String description,
  }) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final col = _experiencesCol(user.uid);
    final docRef = col.doc();

    await docRef.set({
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  Future<void> updateExperience({
    required String id,
    required String title,
    required String company,
    DateTime? startDate,
    DateTime? endDate,
    required String location,
    required String description,
  }) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final docRef = _experiencesCol(user.uid).doc(id);

    await docRef.update({
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteExperience(String id) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final docRef = _experiencesCol(user.uid).doc(id);
    await docRef.delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchExperiences() {
    final user = currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _experiencesCol(user.uid)
        .orderBy('startDate', descending: true)
        .snapshots();
  }

  // =============================
  // Bio
  // =============================

  Future<void> setBio(String? bio) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged-in user');
    }

    await _userDoc(user.uid).update({
      'bio': bio,
    });
  }

  // =============================
  // Projects
  // =============================

  Future<String> addProject({
    required String title,
    required String description,
    List<String> tools = const [],
    String? imageUrl,
    String? projectUrl,
  }) async {
    final user = currentUser;
    print('[ProfileService] addProject for uid=${user?.uid}');
    if (user == null) {
      throw Exception('No logged in user');
    }

    final docRef = _projectsCol(user.uid).doc();

    await docRef.set({
      'title': title,
      'description': description,
      'tools': tools,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  Future<void> updateProject({
    required String id,
    required String title,
    required String description,
    List<String> tools = const [],
    String? imageUrl,
    String? projectUrl,
  }) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final docRef = _projectsCol(user.uid).doc(id);

    await docRef.update({
      'title': title,
      'description': description,
      'tools': tools,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteProject(String id) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('No logged in user');
    }

    final docRef = _projectsCol(user.uid).doc(id);
    await docRef.delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchProjects() {
    final user = currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _projectsCol(user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
