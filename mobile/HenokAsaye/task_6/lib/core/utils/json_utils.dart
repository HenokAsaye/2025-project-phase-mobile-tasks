import 'dart:convert';

class JsonUtils {
  /// Decodes a JSON object into a model class
  static T decodeModel<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    try {
      return fromJson(json);
    } catch (e) {
      throw FormatException('Failed to decode model: $e');
    }
  }

  /// Decodes a list of JSON objects into a list of model classes
  static List<T> decodeList<T>(List<dynamic> jsonList, T Function(Map<String, dynamic>) fromJson) {
    try {
      return jsonList.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw FormatException('Failed to decode list: $e');
    }
  }

  /// Safely extracts a value from a JSON map with a default fallback
  static T? getValue<T>(Map<String, dynamic> json, String key, {T? defaultValue}) {
    try {
      final value = json[key];
      if (value == null) return defaultValue;
      return value as T;
    } catch (e) {
      return defaultValue;
    }
  }

  /// Safely extracts a required value from a JSON map
  static T getRequiredValue<T>(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) {
      throw FormatException('Required field "$key" is missing');
    }
    return value as T;
  }

  /// Converts a model to JSON with error handling
  static Map<String, dynamic> encodeModel<T>(T model, Map<String, dynamic> Function(T) toJson) {
    try {
      return toJson(model);
    } catch (e) {
      throw FormatException('Failed to encode model: $e');
    }
  }

  /// Validates if a string is valid JSON
  static bool isValidJson(String jsonString) {
    try {
      json.decode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Pretty prints JSON for debugging
  static String prettyPrint(Map<String, dynamic> json) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }
}
