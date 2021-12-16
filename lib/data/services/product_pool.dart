import 'dart:convert';
import 'package:flutter_app_bsalon/domain/models/public_product.dart';
import 'package:flutter_app_bsalon/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class ProductPoolService implements MisionTicService {
  //ACTIVIDAD
  // AÑADA SUS CREDENCIALES PARA CONECTARSE AL SERVICIO EXTERNO
  final String baseUrl = 'makeup-api.herokuapp.com';

  @override
  Future<List<PublicProduct>> fecthData({int limit = 5, Map? map}) async {
    // Defina la URI para hacer las peticiones al servicio
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/api/v1/products.json', queryParameters);

    // Implemente la solicitud
    final response = await http.get(uri, headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PublicProduct> products = [];
      for (var product in res) {
        products.add(PublicProduct.fromJson(product));
      }
      return products;
    } else {
      throw Exception('Error on request');
    }
  }
}
