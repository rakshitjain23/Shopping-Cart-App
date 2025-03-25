import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=$limit&skip=${(page - 1) * limit}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['products'] == null || data['total'] == null) {
          throw Exception('Invalid response format');
        }

        return {
          'products': (data['products'] as List)
              .map((product) =>
                  Product.fromJson(product as Map<String, dynamic>))
              .toList(),
          'total': data['total'] as int,
        };
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
