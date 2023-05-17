import 'dart:async';
import 'package:flutter_proyecto/pantalla_detalles.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'http_functions.dart';

// esta pantalla viene a ser una conversacion individual entre dos usuarios.
// no es la pantalla de listado de conversaciones

class ConversationScreen extends StatefulWidget {
  ConversationScreen(this.user_id, this.animal_id, {Key? key}) : super(key: key);
  int user_id = 0, animal_id = 0;
  @override
  State<ConversationScreen> createState() => _ConversationScreenState(user_id, animal_id);
}

class _ConversationScreenState extends State<ConversationScreen> {
  //este user_id es el del OTRO usuario: si eres adopter, le pasarás el de la protectora del animal.
  int user_id = 0, animal_id = 0;
  var myImage, otherUserImage, petInfo;
  List<dynamic> messages = []; // Lista para almacenar los mensajes del chat
  TextEditingController textController = TextEditingController(); // Controlador del campo de texto
  bool isButtonEnabled = false; // Estado del botón de enviar
  bool dataLoaded = false;
  late Timer timer;

  _ConversationScreenState(this.user_id, this.animal_id);
    @override
    void initState(){
      super.initState();
      var data = {
        'user_id': UserSession().type == 'S' ? this.user_id : UserSession().userId,
        'animal_id': animal_id
      };
      initAsync(data);
      startDataUpdateTimer(); // Inicia el temporizador para actualizar los datos cada segundo

    }

    Future<void> initAsync(data) async {
      messages = await getConversation(data);
      petInfo = await getPetDetails({'animal_id': animal_id});
      petInfo['photo'] = await getImage(petInfo['photo']);
      Map<String, dynamic> response = await getProfileInfo({'user_id': UserSession().userId, 'type': UserSession().type});
      myImage = await getImage(response['photo']);
      if (UserSession().type == 'S') {
        response = await getProfileInfo({'user_id': user_id, 'type': 'A'});
      } else {
        response = await getProfileInfo({'user_id': user_id, 'type': 'S'});
      }
      otherUserImage = await getImage(response['photo']);
      dataLoaded = true;

    }
  Future<void> obtainData() async{
    // Lógica para obtener los datos del JSON
    // Actualiza la lista 'messages' con los nuevos mensajes
    var data = {
      'user_id': UserSession().type == 'S' ? this.user_id : UserSession().userId,
      'animal_id': animal_id
    };
    var newData = await getConversation(data);
    setState(() {
      messages = newData;
    });
  }

  void startDataUpdateTimer() {
    // Temporizador para actualizar los datos cada segundo
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      obtainData();

    });
  }

  @override
  void dispose() {
    super.dispose();
    // Detener el timer al salir de la pantalla
    timer.cancel();
  }

  void sendMessage() {
    String message = textController.text;
    int adopterId = 0;
    int writer = 0;
    if (UserSession().type == 'S'){
      adopterId = user_id;
      writer = 1;
    } else if (UserSession().type == 'A') {
      adopterId = UserSession().userId;
    }
    var data = {
      'user_id': adopterId,
      'animal_id': animal_id,
      'writer': writer,
      'date': DateFormat('HH:mm dd/MM/yy').format(DateTime.now()),
      'message': message
    };
    addToChat(data);
    // Limpia el campo de texto y deshabilita el botón de enviar
    textController.clear();
    setState(() {
      isButtonEnabled = false;
    });
  }

  void deleteMessage(index) {
      var messageInfo = {
        'user_id': UserSession().type == 'S' ? user_id : UserSession().userId,
        'animal_id': animal_id,
        'position': index
      };
      deleteIndividualMessage(messageInfo);
  }

  @override
  Widget build(BuildContext context) {
    return !dataLoaded ? Center(child: CircularProgressIndicator()) : Builder(builder: (context) =>
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: Text(
              '${petInfo['name']}',
              style: GoogleFonts.quicksand(fontSize: 35.0, color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.brown,
            actions: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: InkWell(
                  onTap: () {
                    DetailScreen detalles = DetailScreen(animal_id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => detalles,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 37,
                    backgroundImage: petInfo['photo'].image,
                  ),
                ),
              ),
            ],
            leading: Builder(
              builder: (BuildContext context) {
                if (Navigator.of(context).canPop()) {
                  return BackButton(onPressed: () => Navigator.pop(context));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          body:
          Column(
            children: [
              SizedBox(height: 20.0,),
              messages.isEmpty ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.forum_rounded, color: Colors.brown, size: 48.0),
                      SizedBox(height: 10.0),
                      Text(
                        "No tienes mensajes disponibles",
                        style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ) :
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> message = messages[index];
                    bool isWriterLeft;
                    if (UserSession().type == 'S') {
                      isWriterLeft = message['writer'] == 1;
                    } else {
                      isWriterLeft = message['writer'] == 0;
                    }

                    return GestureDetector(
                      onLongPress: () {
                        bool currentUser = false;
                        if (UserSession().type == 'S') {
                          if (messages[index]['writer'] == 1) {
                            currentUser = true;
                          }
                        } else if (UserSession().type == 'A') {
                          if (messages[index]['writer'] == 0) {
                            currentUser = true;
                          }
                        }
                        if (currentUser) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Eliminar mensaje', style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w600),),
                                content: Text('¿Deseas eliminar este mensaje?', style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w400),),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar', style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w800),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Eliminar', style: GoogleFonts.quicksand(color: Colors.brown, fontWeight: FontWeight.w800),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      deleteMessage(index);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: ListTile(
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: isWriterLeft ? Colors.green[200] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                            children: [
                              Text(
                                message['message'],
                                style: GoogleFonts.quicksand(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                message['date'],
                                style: GoogleFonts.quicksand(fontSize: 12.0, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        leading: !isWriterLeft && otherUserImage != null
                            ? CircleAvatar(
                          backgroundImage: otherUserImage.image,
                        )
                            : null,
                        trailing: isWriterLeft && myImage != null
                            ? CircleAvatar(
                          backgroundImage: myImage.image,
                        )
                            : null,
                      ),
                    );

                  },
                ),
              ),

              Divider(),
              Container(
                height: 60.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextField(
                          cursorColor: Colors.brown,
                          controller: textController,
                          onChanged: (value) {
                            setState(() {
                              isButtonEnabled = value.isNotEmpty;
                            });
                          },
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: 'Escribe un mensaje',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: isButtonEnabled ? sendMessage : null,
                      backgroundColor: isButtonEnabled ? Colors.brown : Colors.grey,
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        );
  }
}