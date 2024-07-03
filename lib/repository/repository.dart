import 'dart:convert';

import 'package:http/http.dart' as http;

class Repository {
  Future<dynamic> requestGET({required String url}) async {
    final result = await http.get(Uri.parse(url.toString()));
    if (result.statusCode == 200) {
      if (result.body.isNotEmpty) {
        final jsonObject = json.decode(result.body);
        return jsonObject;
      } else {
        return {};
      }
    } else {
      return {};
    }
  }
}
