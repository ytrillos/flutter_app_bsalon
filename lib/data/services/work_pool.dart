import 'dart:convert';
import 'package:flutter_app_bsalon/domain/models/public_job.dart';
import 'package:flutter_app_bsalon/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class WorkPoolService implements MisionTicService {
  //ACTIVIDAD
  // AÑADA SUS CREDENCIALES PARA CONECTARSE AL SERVICIO EXTERNO
  final String baseUrl = 'misiontic-2022-uninorte.herokuapp.com';
  final String apiKey = '.F3XQFC84PNRaomtpC3pg.jBGS/urk3NK0da43lK5mvucHM5p4kpu';

  @override
  Future<List<PublicJob>> fecthData({int limit = 5, Map? map}) async {
    // Defina la URI para hacer las peticiones al servicio
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/jobs', queryParameters);

    // Implemente la solicitud
    final response = await http.get(uri, headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
      'key': apiKey
    });

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PublicJob> jobs = [];
      for (var job in res['jobs']) {
        jobs.add(PublicJob.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Error on request');
    }
  }
}
