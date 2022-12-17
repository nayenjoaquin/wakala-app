import 'package:http/http.dart' as http;

class WakalasService {
  Future<http.Response> getWakalas() async {
    return await http.get(
      Uri.parse(
        'https://882aa2605781.sa.ngrok.io/api/wuakalasApi/Getwuakalas',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }
}
