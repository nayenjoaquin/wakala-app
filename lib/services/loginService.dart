import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  Future<http.Response> validar(String login, String pass) async {
    return await http.get(
      Uri.parse(
          'https://882aa2605781.sa.ngrok.io/api/usuariosApi/Getusuario?email=' +
              login +
              '&password=' +
              pass),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
