import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/api_constant.dart';

class ApiService extends GetxService {
  factory ApiService.instance() => ApiService._();
  http.Client? client;
  ApiService._() {
    client = http.Client();
  }

  Future<http.Response> _getRequest(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on TimeoutException {
      throw HttpException('Request timeout');
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<http.Response> _postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on TimeoutException {
      throw HttpException('Request timeout');
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _getRequest(endpoint);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final response = await _postRequest(endpoint, body);
    return jsonDecode(response.body);
  }
}
