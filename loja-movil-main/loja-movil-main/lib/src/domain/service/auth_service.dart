import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String _clientId = 'flutter-client';
  final String _clientSecret =
      'YOUR_CLIENT_SECRET'; // Replace with your client secret
  final String _tokenUrl =
      'http://localhost:8080/auth/realms/flutter-realm/protocol/openid-connect/token';

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'grant_type': 'password',
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body);
        await _secureStorage.write(
            key: 'accessToken', value: result['access_token']);
        await _secureStorage.write(
            key: 'refreshToken', value: result['refresh_token']);
      } else {
        debugPrint('Failed to login: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error during login: $e');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refreshToken');
  }
}
