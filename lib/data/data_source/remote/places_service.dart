import 'package:dio/dio.dart';

class PlacesService {
  static const String _apiKey = 'AIzaSyDuKguBEQA-aKJyd-H47t0Gg9GcswNDtrA';
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  final Dio _dio = Dio();

  /// Fetches autocomplete suggestions for the given [input] text.
  /// Returns a list of maps with 'description' and 'placeId'.
  Future<List<Map<String, String>>> getAutocompleteSuggestions(
    String input,
  ) async {
    if (input.isEmpty) return [];

    try {
      final response = await _dio.get(
        '$_baseUrl/autocomplete/json',
        queryParameters: {'input': input, 'key': _apiKey},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final predictions = data['predictions'] as List<dynamic>? ?? [];

        return predictions.map<Map<String, String>>((p) {
          return {
            'description': p['description'] as String? ?? '',
            'placeId': p['place_id'] as String? ?? '',
          };
        }).toList();
      }

      return [];
    } catch (e) {
      print('PlacesService autocomplete error: $e');
      return [];
    }
  }

  /// Fetches lat/lng details for a given [placeId].
  /// Returns a map with 'address', 'lat', 'lng'.
  Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'formatted_address,geometry',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final result = response.data['result'];
        if (result == null) return null;

        final location = result['geometry']?['location'];
        return {
          'address': result['formatted_address'] ?? '',
          'lat': (location?['lat'] ?? 0.0).toDouble(),
          'lng': (location?['lng'] ?? 0.0).toDouble(),
        };
      }

      return null;
    } catch (e) {
      print('PlacesService details error: $e');
      return null;
    }
  }
}
