import 'dart:convert';

import 'package:http/http.dart' as http;

class CommentsService {
  Future<http.Response> postComment(Map<String, dynamic> comment) async {
    return await http.post(
      Uri.parse(
        'https://985cd18612e9.sa.ngrok.io/api/comentariosApi/Postcomentario',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comment),
    );
  }
}
