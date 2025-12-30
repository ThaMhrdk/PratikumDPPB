// lib/services/lowongan_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_service.dart';
import '../models/lowongan.dart';

class LowonganService {
  final AuthService _authService = AuthService();

  // Get semua lowongan
  Future<List<Lowongan>> getAllLowongan() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lowongan}'),
        headers: ApiConfig.headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List lowonganData = data['data'];

        return lowonganData.map((json) => Lowongan.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      print('Error getting lowongan: $e');
      return [];
    }
  }

  // Get detail lowongan
  Future<Lowongan?> getLowonganById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lowongan}/$id'),
        headers: ApiConfig.headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Lowongan.fromJson(data['data']);
      }

      return null;
    } catch (e) {
      print('Error getting lowongan detail: $e');
      return null;
    }
  }

  // Tambah lowongan (admin only)
  Future<Map<String, dynamic>> createLowongan({
    required String posisi,
    required String perusahaan,
    required String lokasi,
    required String tipe,
    required String deskripsi,
  }) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Anda belum login'};
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lowongan}'),
        headers: ApiConfig.headers(token: token),
        body: jsonEncode({
          'posisi': posisi,
          'perusahaan': perusahaan,
          'lokasi': lokasi,
          'tipe': tipe,
          'deskripsi': deskripsi,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Lowongan berhasil ditambahkan'};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal menambahkan lowongan',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
