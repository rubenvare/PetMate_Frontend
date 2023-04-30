import 'dart:convert';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_proyecto/singleton_user.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_proyecto/global.dart';

import 'package:flutter/material.dart';


Future<http.Response> sendPostRequest(String path, dynamic data) async {
  final url = Uri.parse('$baseUrl$path');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data),
  );
  return response;
}


Image getImage(String urlRequest)  {
  var respuesta = Image.network('$baseImage$urlRequest');
  return respuesta;
}

//permite añadir la imagen
Future<void> postImage(String type, XFile image, String name) async {
  final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/PUSH_IMAGE/$type'));
  request.files.add(await http.MultipartFile.fromPath('image', image.path, filename: '$name.jpg'));
  await request.send();
}

Future<bool> sendLoginRequest(dynamic data) async {
  final path = '/login';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
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


Future<Map<String,dynamic>> showPets(dynamic data) async {
  final path = '/S_show_pets';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
  }

  return datos;
}
Future<Map<String, dynamic>> sendAddPetRequest(dynamic data) async {
  final path = '/S_add_pet';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  } else {
    return datos;
    final responseBody = json.decode(response.body);
}
}

Future<Map<String, dynamic>> getNextPet(dynamic data) async {
  final path = '/A_next_pet';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    print('Error en la solicitud de siguiente animal: ${response.reasonPhrase}');
  }

  return datos;
}

Future<Map<String, dynamic>> getPetDetails(dynamic data) async {
  final path = '/show_pet';
  final response = await sendPostRequest(path, data);
  var detalles = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  }
  else {
    return detalles;
  }
}

Future<Map<String, dynamic>> getProfileInfo(dynamic data) async {
  final path = '/show_profile';
  final response = await sendPostRequest(path, data);
  var info = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  }
  else {
    return info;

  }
}