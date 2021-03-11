import 'package:http/http.dart' as http;
import 'dart:convert';

class Info {
  Future<dynamic> getData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');

    var data = response.body;
    if (response.statusCode == 200) {
      print(response.statusCode);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getWorldData() async {
    http.Response response = await http.get(
        'https://corona-virus-world-and-india-data.p.rapidapi.com/api',
        headers: {
          'x-rapidapi-host': "corona-virus-world-and-india-data.p.rapidapi.com",
          'x-rapidapi-key': "3b9c9d110cmsh241a5d6cbfd4f3ep176defjsn7dfce8db9d47"
        });
    var data = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
