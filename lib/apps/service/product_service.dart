import 'package:demo_apps/apps/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> readApi() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://api.escuelajs.co/api/v1/products"),
      );

      if (response.statusCode == 200) {
        return productModelFromJson(response.body);
      } else {
        throw Exception("error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception: ${e.toString()}");
    }
  }

  // Search_servce
  Future<List<ProductModel>> searchData(String title) async {
    if (title.isEmpty) {
      return [];
    }
    try {
      http.Response response = await http.get(
        Uri.parse("https://api.escuelajs.co/api/v1/products/?title=$title"),
      );

      if (response.statusCode == 200) {
        return productModelFromJson(response.body);
      } else {
        throw Exception("error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Exception: ${e.toString()}");
    }
  }
}
