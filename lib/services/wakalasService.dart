import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wakala.dart';

class WakalasService {
  Future<http.Response> getWakalas() async {
    return await http.get(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/wuakalasApi/Getwuakalas',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<http.Response> postWakalas(Map<String, dynamic> json) async {
    return await http.post(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/wuakalasApi/Postwuakalas',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(json),
    );
  }

  Future<http.Response> getWakala(int id) async {
    return await http.get(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/wuakalasApi/Getwuakala/' +
            id.toString(),
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<http.Response> putSigueAhi(int id) async {
    return await http.put(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/wuakalasApi/PutSigueAhi/${id.toString()}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<http.Response> putYaNoEsta(int id) async {
    return await http.put(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/wuakalasApi/PutYanoEsta/${id.toString()}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }
}
