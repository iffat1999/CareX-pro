import 'package:http/http.dart' as http;
import 'dart:convert';

class DietplanService {
  String url = 'https://carexproai.iffatofficial9.workers.dev/';

  Future<http.Response> postDietPlan({required String prompt}) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({"prompt": prompt}),
    );

    return response;
  }
}
