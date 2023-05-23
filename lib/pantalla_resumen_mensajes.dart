import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_conversacion.dart';
import 'package:flutter_proyecto/pantalla_protectora.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inicio.dart';
import 'http_functions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageSummaryScreen extends StatefulWidget {
  MessageSummaryScreen({Key? key}) : super(key: key);
  @override
  State<MessageSummaryScreen> createState() => _MessageSummaryScreenState();
}

class _MessageSummaryScreenState extends State<MessageSummaryScreen> {
  StreamController<List<dynamic>> _streamController = StreamController<List<dynamic>>();
  List<dynamic> response = [];
  List<int> selectedChats = [];

  _MessageSummaryScreenState();

  @override
  void initState() {
    super.initState();
    startDataUpdates();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<List<dynamic>> getChatRecordAsync(data) async {
    List<dynamic> response = await getChatRecord(data);
    for (int i = 0; i < response.length; i++) {
      var animal_detail = await getPetDetails({'animal_id': response[i]['animal_id']});
      response[i]['animal_photo'] = await getImage(animal_detail['photo']);
      response[i]['shelter_id'] = animal_detail['shelter_id'];
    }
    return response;
  }

  Future<void> startDataUpdates() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      List<dynamic> newData = await getChatRecordAsync({
        'user_id': UserSession().userId,
        'type': UserSession().type,
      });
      _streamController.add(newData);
    }
  }

  Future<void> deleteChat(data) async {
    await deleteChatRecord(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetMateAppBar(),
      body: StreamBuilder<List<dynamic>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(AppLocalizations.of(context)!.errorObtDatos),
            );
          } else  if (snapshot.data?.length == 0) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 50.0), // Ajusta el padding superior e inferior según sea necesario
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.forum_rounded, color: Colors.brown, size: 48.0),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)!.noMensajesDispo,
                      style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          } else {
            response = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      AppLocalizations.of(context)!.mensajes,
                      style: GoogleFonts.quicksand(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: response.length,
                      itemBuilder: (context, index) {
                        final chat = response[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                ConversationScreen conversation = ConversationScreen(UserSession().type == 'S' ? response[index]['user_id'] : response[index]['shelter_id'], response[index]['animal_id']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => conversation,
                                  ),
                                );
                              },
                              onLongPress: () {
                                // Si se mantiene pulsado el chat, se selecciona/deselecciona
                                setState(() {
                                  if (selectedChats.contains(index)) {
                                    selectedChats.remove(index);
                                  } else {
                                    selectedChats.add(index);
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(10.0),
                              highlightColor: Colors.white24, // Color de resaltado al tocar el ListTile
                              splashColor: Colors.white24, // Color de salpicadura al tocar el ListTile
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, // Color del borde del ListTile
                                    width: 1.0, // Ancho del borde del ListTile
                                  ),

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  leading: ClipOval(
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child: response[index]['animal_photo'],
                                    ),
                                  ),
                                  title: Text(
                                    "${response[index]['animal_name']}",
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${response[index]['last_message']}' == '{}' ? 'Toca para iniciar conversación' : '${response[index]['last_message']['message']}',
                                    style: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
                                  ),
                                  trailing: selectedChats.contains(index)
                                      ? IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          selectedChats.remove(index);
                                          var data = {
                                            'user_id': UserSession().type == 'S' ? response[index]['user_id'] : UserSession().userId,
                                            'animal_id': response[index]['animal_id']
                                          };
                                          deleteChat(data);
                                        },
                                      )
                                          : null,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0), // Espacio entre cada ListTile
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: UserSession().type == 'S' ? PetMateShelterNavBar() : PetMateNavBar(),
    );
  }
}

