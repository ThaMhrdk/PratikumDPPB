// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class AuthService {
  // Key untuk menyimpan token
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Registrasi
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.register}'),
        headers: ApiConfig.headers(),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password, // Laravel butuh ini
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Simpan token (bisa 'token' atau 'access_token')
        final token = data['token'] ?? data['access_token'];
        if (token != null) {
          await _saveToken(token);
        }
        if (data['user'] != null) {
          await _saveUserData(data['user']);
        }
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi berhasil',
        };
      } else {
        // Handle error response dari Laravel
        String errorMessage = 'Registrasi gagal';

        if (data['message'] != null) {
          errorMessage = data['message'];
        } else if (data['errors'] != null) {
          // Laravel validation errors
          final errors = data['errors'] as Map<String, dynamic>;
          errorMessage = errors.values.first[0];
        }

        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // Login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.login}'),
        headers: ApiConfig.headers(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Laravel Sanctum biasanya return 'access_token' atau 'token'
        final token = data['access_token'] ?? data['token'];
        if (token != null) {
          await _saveToken(token);
        }
        if (data['user'] != null) {
          await _saveUserData(data['user']);
        }
        return {'success': true, 'message': 'Login berhasil', 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login gagal'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // Logout
  Future<Map<String, dynamic>> logout() async {
    try {
      final token = await getToken();

      if (token != null) {
        await http.post(
          Uri.parse('${ApiConfig.baseUrl}${ApiConfig.logout}'),
          headers: ApiConfig.headers(token: token),
        );
      }

      // Hapus token dan data user
      await _removeToken();
      await _removeUserData();

      return {'success': true, 'message': 'Logout berhasil'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final token = await getToken();

      if (token == null) return null;

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.me}'),
        headers: ApiConfig.headers(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveUserData(data['user']);
        return data['user'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Simpan token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Hapus token
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Simpan data user
  Future<void> _saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  // Get data user
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);

    if (userData != null) {
      return jsonDecode(userData);
    }

    return null;
  }

  // Hapus data user
  Future<void> _removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Check apakah user sudah login
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
