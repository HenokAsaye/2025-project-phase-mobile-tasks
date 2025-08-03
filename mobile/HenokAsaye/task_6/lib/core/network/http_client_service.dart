import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/exceptions.dart';
import '../constants/api_constants.dart';

class HttpClientService {
  final http.Client _client;
  final String _baseUrl;
  final Map<String, String> _defaultHeaders;

  HttpClientService({
    required http.Client client,
    String? baseUrl,
    Map<String, String>? defaultHeaders,
  })  : _client = client,
        _baseUrl = baseUrl ?? ApiConstants.baseUrl,
        _defaultHeaders = defaultHeaders ?? ApiConstants.headers;

  /// Generic GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.get(
        uri,
        headers: {..._defaultHeaders, ...?headers},
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Generic POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.post(
        uri,
        headers: {..._defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Generic PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.put(
        uri,
        headers: {..._defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Generic DELETE request
  Future<void> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParameters);
      final response = await _client.delete(
        uri,
        headers: {..._defaultHeaders, ...?headers},
      );

      _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    if (queryParameters != null) {
      return uri.replace(queryParameters: queryParameters.map((key, value) => MapEntry(key, value.toString())));
    }
    return uri;
  }
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      try {
        return json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        final list = json.decode(response.body) as List<dynamic>;
        return {'data': list};
      }
    } else {
      throw ServerException();
    }
  }
} 