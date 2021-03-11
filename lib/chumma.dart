import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  Thing thing = Thing();
  thing.getData();
}

class Thing {
  Future<dynamic> getData() async {
    http.Response response = await http.get(
        'https://corona-virus-world-and-india-data.p.rapidapi.com/api',
        headers: {
          'x-rapidapi-host': "corona-virus-world-and-india-data.p.rapidapi.com",
          'x-rapidapi-key': "3b9c9d110cmsh241a5d6cbfd4f3ep176defjsn7dfce8db9d47"
        });

    // await http.get('https://corona-virus-world-and-india-data.p.rapidapi.com/api',headers:{
    //   'x-rapidapi-host': "corona-virus-world-and-india-data.p.rapidapi.com",
    //   'x-rapidapi-key': "3b9c9d110cmsh241a5d6cbfd4f3ep176defjsn7dfce8db9d47"
    // });

    var data = response.body;

    if (response.statusCode == 200) {
      print(response.statusCode);
      var k = jsonDecode(data);
      String name = "St. Barth";
      for (int i = 0; i < 213; i++) {
        var c = k["countries_stat"][i]["country_name"];
        if (c == name) {
          var o = k["countries_stat"][i]["cases"];
          print(o);
        }
      }
    } else {
      print(response.statusCode);
    }
  }
}
