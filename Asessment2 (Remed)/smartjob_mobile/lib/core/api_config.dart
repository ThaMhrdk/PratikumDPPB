// lib/services/api_config.dart
class ApiConfig {
  // Base URL API Laravel - IP Hotspot laptop
  static const String baseUrl = 'http://192.168.137.1:8000/api';

  // Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String me = '/me';

  static const String lowongan = '/lowongan';
  static const String lamaran = '/lamaran';

  // Headers
  static Map<String, String> headers({String? token}) {
    final map = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      map['Authorization'] = 'Bearer $token';
    }

    return map;
  }

  // Headers untuk upload file
  static Map<String, String> multipartHeaders({String? token}) {
    final map = <String, String>{'Accept': 'application/json'};

    if (token != null) {
      map['Authorization'] = 'Bearer $token';
    }

    return map;
  }
}
