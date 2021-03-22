import 'dart:convert';


import 'package:http/http.dart' as http;

class NetworkHelper {

  final URL;

  NetworkHelper({this.URL});


  Future <dynamic> getData() async {
    print("url : " + URL);

    http.Response response = await http.get((URL));

    if (response.statusCode == 200) {
      print("Network class konusuyor :" + response.body);

      String a = response.body;
      return jsonDecode(a);
    } else
      print(response.statusCode);
  }
}


