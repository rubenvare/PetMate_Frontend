import 'dart:convert';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_proyecto/global.dart';


Future<http.Response> sendPostRequest(String path, dynamic data) async {
  final url = Uri.parse('$baseUrl$path');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );
  return response;
}

Future<bool> sendLoginRequest(dynamic data) async {
  final path = '/login';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else if (response.statusCode == 500){
    print('Usuario no encontrado');
    return Future<bool>.value(false);
  } else {
    final responseBody = json.decode(response.body);
    UserSession().userId = responseBody["user_id"];
    UserSession().type = responseBody["type"];

    return Future<bool>.value(true);
    // Aquí puedes procesar la respuesta como sea necesario
  }
}

Future<bool> sendRegisterRequest(dynamic data) async {
  final path = '/register';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(true);
    final responseBody = json.decode(response.body);
  }
}

Future<void> sendShowProfileDataRequest(dynamic data) async {
  final path = '/showProfileData';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
  } else {
    final responseBody = json.decode(response.body);
    // Aquí puedes procesar la respuesta como sea necesario
  }
}