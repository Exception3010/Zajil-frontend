import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/models/user_model.dart';

class UserService {
  // Replace with your actual server URL
  final String baseUrl = 'https://your-api-server.com/api';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Helper to get the ID token for authenticated requests
  Future<Map<String, String>> _getHeaders() async {
    final user = _auth.currentUser;
    final token = await user?.getIdToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Create or update user profile on your server
  Future<void> saveUserProfile(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: await _getHeaders(),
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save user profile: ${response.body}');
    }
    
    // Also save username locally for offline access
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
  }

  // Check if a username is already taken on your server
  Future<bool> isUsernameAvailable(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/check-username?username=$username'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['available'] as bool;
    } else {
      throw Exception('Failed to check username availability');
    }
  }

  // Get user profile by UID from your server
  Future<UserModel?> getUserProfile(String uid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$uid'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to get user profile');
    }
  }

  // Current User Helper
  User? get currentUser => _auth.currentUser;
}
