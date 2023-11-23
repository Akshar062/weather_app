import 'dart:convert';
import 'package:http/http.dart' as http;
import 'key.dart';

Future<Map<String, dynamic>> getCurrantWeather() async {
  try {
    String city = "Surat";
    final responce = await http.get(
      Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$key"),
    );
    final data = jsonDecode(responce.body);
    if (data['cod'] != '200') {
      throw data['Error occurred'];
    } else {
      return data;
    }
  } catch (e) {
    throw e.toString();
  }
}

