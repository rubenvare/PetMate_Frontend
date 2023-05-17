import 'dart:convert';
import 'dart:ui';

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

Future<bool> retirePet(dynamic data) async {
  final path = '/S_retire_pet';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else {
    final responseBody = json.decode(response.body);
    return Future<bool>.value(true);
    // Aquí puedes procesar la respuesta como sea necesario
  }
}

Future<bool> sendUpdateAnimalRequest(dynamic data) async {
  final path = '/S_update_pet';
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

Future<Map<String,dynamic>> showPet(dynamic data) async {
  final path = '/S_show_pet';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
  }
  return datos;
}

Future<bool> sendAddPetRequest(dynamic data) async {
  final path = '/S_add_pet';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(true);
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

Future<Map<String,dynamic>> showLikesReceived(dynamic data) async {
  final path = '/S_show_likes_received';
  final response = await sendPostRequest(path, data);
  var info = jsonDecode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO ANIMALES LIKEADOS'};
  }
  else {
    return info;
  }
}

Future<bool> resolveLikeReceived(dynamic data) async {
  final path = '/S_resolve_like_received';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    return false;
  }
  else {
    return true;
  }
}

