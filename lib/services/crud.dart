import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDMxZjFkMTY5ODZlYjBjYzQwODhmMWJlZDI4MTc0MiIsInN1YiI6IjY0NzdiYjc1MDc2Y2U4MDBlNjQ2NTEzNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Xzgyq60FDKX8DztTfi7JfC5y1QkLIQzpuisrrwt358s"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var responsebody = jsonDecode(response.body);
        print(response.body);

        return response.body;
      } else {
        print("Error ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }
  }
}
