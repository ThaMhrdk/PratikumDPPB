// lib/services/lamaran_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'auth_service.dart';
import '../models/lamaran.dart';

class LamaranService {
  final AuthService _authService = AuthService();

  // Get semua lamaran user
  Future<List<Lamaran>> getMyLamaran() async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lamaran}'),
        headers: ApiConfig.headers(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List lamaranData = data['data'];

        return lamaranData.map((json) => Lamaran.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      print('Error getting lamaran: $e');
      return [];
    }
  }

  // Get detail lamaran
  Future<Lamaran?> getLamaranById(int id) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lamaran}/$id'),
        headers: ApiConfig.headers(token: token),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Lamaran.fromJson(data['data']);
      }

      return null;
    } catch (e) {
      print('Error getting lamaran detail: $e');
      return null;
    }
  }

  // Kirim lamaran + upload CV
  Future<Map<String, dynamic>> submitLamaran({
    required int lowonganId,
    File? cvFile,
    String? namaLengkap,
  }) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Anda belum login'};
      }

      // Get user data untuk nama lengkap jika tidak disediakan
      final userData = await _authService.getUserData();

      String nama = namaLengkap ?? '';
      if (nama.isEmpty) {
        nama = userData?['name'] ?? 'User';
      }

      String email = userData?['email'] ?? '';
      String noTelepon =
          userData?['phone'] ?? userData?['no_telepon'] ?? '081234567890';

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lamaran}'),
      );

      request.headers.addAll(ApiConfig.multipartHeaders(token: token));
      request.fields['lowongan_id'] = lowonganId.toString();
      request.fields['nama_lengkap'] = nama;
      request.fields['email'] = email;
      request.fields['no_telepon'] = noTelepon;

      // Upload CV jika ada
      if (cvFile != null) {
        request.files.add(await http.MultipartFile.fromPath('cv', cvFile.path));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Lamaran berhasil dikirim',
        };
      } else {
        // Handle Laravel validation errors
        String errorMessage = 'Gagal mengirim lamaran';

        if (data['message'] != null) {
          errorMessage = data['message'];
        } else if (data['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;
          errorMessage = errors.values.first[0];
        }

        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Upload CV saja
  Future<Map<String, dynamic>> uploadCV({
    required int lamaranId,
    required File cvFile,
  }) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Anda belum login'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${ApiConfig.baseUrl}${ApiConfig.lamaran}/$lamaranId/upload-cv',
        ),
      );

      request.headers.addAll(ApiConfig.multipartHeaders(token: token));
      request.files.add(await http.MultipartFile.fromPath('cv', cvFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'CV berhasil diupload'};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal upload CV',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Upload dokumen pendukung
  Future<Map<String, dynamic>> uploadDokumen({
    required int lamaranId,
    required File dokumenFile,
  }) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Anda belum login'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${ApiConfig.baseUrl}${ApiConfig.lamaran}/$lamaranId/upload-dokumen',
        ),
      );

      request.headers.addAll(ApiConfig.multipartHeaders(token: token));
      request.files.add(
        await http.MultipartFile.fromPath('dokumen', dokumenFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Dokumen berhasil diupload'};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal upload dokumen',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Hapus lamaran
  Future<Map<String, dynamic>> deleteLamaran(int id) async {
    try {
      final token = await _authService.getToken();

      if (token == null) {
        return {'success': false, 'message': 'Anda belum login'};
      }

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.lamaran}/$id'),
        headers: ApiConfig.headers(token: token),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Lamaran berhasil dihapus'};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal menghapus lamaran',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
