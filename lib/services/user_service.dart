import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/models/user_model.dart';

/// Reads and writes user profiles in Cloud Firestore.
///
/// Profiles live in the `users` collection keyed by Firebase Auth UID.
/// `createdAt` is stored as a Firestore [Timestamp] (sortable/queryable) and
/// converted to/from the ISO-8601 string that the Firestore-agnostic
/// [UserModel] expects, so the model never has to depend on cloud_firestore.
class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'zajil',
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  /// Create or update the user's profile document.
  Future<void> saveUserProfile(UserModel user) async {
    final data = user.toJson();
    // Store the date as a native Firestore Timestamp rather than a string.
    data['createdAt'] = Timestamp.fromDate(user.createdAt);
    await _users.doc(user.uid).set(data);

    // Cache the username locally for fast/offline launch (see SplashScreen).
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
  }

  /// Returns true if no existing profile already claims [username].
  Future<bool> isUsernameAvailable(String username) async {
    final query =
        await _users.where('username', isEqualTo: username).limit(1).get();
    return query.docs.isEmpty;
  }

  /// Fetch a profile by UID, or null if none exists yet.
  Future<UserModel?> getUserProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    final data = doc.data();
    if (!doc.exists || data == null) return null;
    return UserModel.fromJson(_normalize(data));
  }

  /// Converts Firestore-native types into the plain JSON [UserModel] expects.
  /// `createdAt` may be a [Timestamp] (current writes / console-created docs) or
  /// already an ISO-8601 string (legacy docs) — normalize both to a string.
  Map<String, dynamic> _normalize(Map<String, dynamic> data) {
    final createdAt = data['createdAt'];
    if (createdAt is Timestamp) {
      return {...data, 'createdAt': createdAt.toDate().toIso8601String()};
    }
    return data;
  }

  // Current User Helper
  User? get currentUser => _auth.currentUser;
}
