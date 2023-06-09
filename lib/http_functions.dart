import 'dart:convert';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_proyecto/singleton_user.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_proyecto/global.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


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
  } else if (datos.containsKey('ERROR')){
    return Future<bool>.value(false);
  } else {
    final responseBody = json.decode(response.body);
    UserSession().userId = responseBody["user_id"];
    UserSession().type = responseBody["type"];

    return Future<bool>.value(true);

  }
}

Future<Map<String, dynamic>> sendRegisterRequest(dynamic data) async {
  final path = '/register';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  } else {
    return datos;
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
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  } else {
    return datos;
  }
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

Future<List<dynamic>> getChatRecord(dynamic data) async {
  final path= '/show_chat_record';
  final response = await sendPostRequest(path, data);
  var info = jsonDecode(response.body);
  if (response.statusCode != 200) {
    return ['ERROR OBTENIENDO CHATS'];
  }
  else {
    return info;
  }
}

Future<List<dynamic>> getConversation(dynamic data) async {
  final path = '/show_chat';
  final response = await sendPostRequest(path, data);
  var info = jsonDecode(response.body);
  if (response.statusCode != 200) {
    return [{'error':'ERROR OBTENIENDO CHAT'} ];
  }
  else {
    return info;
  }
}

Future<void> addToChat(dynamic data) async {
  final path = '/add_to_chat';
  final response = await sendPostRequest(path, data);
  var info = jsonDecode(response.body);
}

Future<void> deleteChatRecord(dynamic data) async {
  final path = '/delete_chat';
  final response = await sendPostRequest(path, data);
}

Future<void> deleteIndividualMessage(dynamic data) async {
  final path = '/delete_message';
  final response = await sendPostRequest(path, data);
}

Future<Map<String, dynamic>> sendUpdateShelterRequest(dynamic data) async {
  final path = '/update_profile';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL SHELTER'};
  } else {
    return datos;
    final responseBody = json.decode(response.body);
  }
}

Future<Map<String,dynamic>> retiredRecord(dynamic data) async {
  final path = '/S_retired_record';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  } else {
    return datos;
  }
}

Future<Map<String,dynamic>> savedRecord(dynamic data) async {
  final path = '/A_saved_record';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ANIMAL'};
  } else {
    return datos;
  }
}

Future<bool> resolveSavePet(dynamic data) async {
  final path = '/A_resolve_save_pet';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(true);
  }
}


Future<Map<String, dynamic>> sendModifyUserRequest(dynamic data) async {
  final path = '/update_profile';
  final response = await sendPostRequest(path, data);
  var datos = json.decode(response.body);
  if (response.statusCode != 200) {
    return {'error': 'ERROR OBTENIENDO INFORMACIÓN DEL ADOPTANTE'};
  } else {
    return datos;
  }
}


Future<bool> deleteHistory (dynamic data) async {
  final path = '/A_delete_history';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(true);
    final responseBody = json.decode(response.body);
  }
}

Future<bool> deleteProfile (dynamic data) async {
  final path = '/delete_profile';
  final response = await sendPostRequest(path, data);
  if (response.statusCode != 200) {
    print('Error en la solicitud: ${response.reasonPhrase}');
    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(true);
    final responseBody = json.decode(response.body);
  }
}

