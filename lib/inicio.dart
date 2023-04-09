import 'package:flutter/material.dart';
import 'package:flutter_proyecto/router.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/http_functions.dart';



class InicioSesion extends StatefulWidget {
  @override
  State<InicioSesion> createState() => InicioSesionState();
}

class InicioSesionState extends State<InicioSesion> {
  final formKey = GlobalKey<FormState>();
  bool errorMailRegExp = false;
  bool errorMailEmpty = false;
  bool errorPassword = false;
  String email = '';
  String password = '';
  RegExp coincideMail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PetMateAppBar(),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFC4A484),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ // Agregue espacio en blanco sobre el texto
                Text(
                  "¡BIENVENIDO!",
                  style: GoogleFonts.quicksand(
                    fontSize: 37.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 70), // Agregue espacio en blanco debajo del texto
                Form(
                  key: formKey,
                  child: Container(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)
                            ),

                            labelText: 'Correo electrónico',
                            labelStyle: GoogleFonts.quicksand(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.brown
                            ),

                          ),

                          validator: (value){
                            if (value == null || value.isEmpty == true) {
                              setState(() {
                                errorMailEmpty = true;
                              });
                              return 'Este campo es obligatorio';
                            }
                            else {
                              if (!coincideMail.hasMatch(value)) {
                                setState(() {
                                  errorMailRegExp = true;
                                });
                                return 'por favor, sigue el formato user@domain.com';
                              }
                              else {
                                email = value;
                                return null;
                              }
                            }
                          },
                        ),
                        SizedBox(height: 40), // Agregue espacio en blanco entre los campos de texto
                        TextFormField(
                          cursorColor: Colors.brown,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)
                              ),
                              labelText: 'Contraseña',
                              labelStyle: GoogleFonts.quicksand(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown
                              )
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              setState(() {
                                errorPassword = true;
                              });
                              return 'Por favor, rellena el campo con tu contraseña.';
                            }
                            password = value;
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              var body = {
                                'email': email,
                                'password': password,
                              };
                              if (await sendLoginRequest(body)){
                                Navigator.pushNamed(context, PantallaTestRoute);
                              } else {
                                openDialog();
                                formKey.currentState?.reset();

                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                            ),
                            child: Text(
                                "LOGIN",
                                style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0,

                                ))),
                        SizedBox(height: 50),
                        Text("¿No tienes cuenta?",
                            style: GoogleFonts.quicksand(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,

                            )
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton( onPressed: () {Navigator.pushNamed(context, RegistroRoute);},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                            ),
                            child: Text(
                                "REGISTRO",
                                style: GoogleFonts.quicksand(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0
                                ))),
                      ],
                    ),
                  ),
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }
  Future<void> openDialog() => showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Usuario no encontrado'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'))
        ],
      )
  );
}

class PetMateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PetMateAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(toolbarHeight: 70,
      title: Text(
        'PetMate',
        style:
        GoogleFonts.alfaSlabOne(fontSize: 35.0, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.brown,
      actions: const [
        Padding(padding: EdgeInsets.all(20.0), child: Icon(Icons.pets_rounded))
      ],
      leading: Builder(
        builder: (BuildContext context) {
          if (Navigator.of(context)
              .canPop()) { // Si puede hacer pop te mostrará el icono
            return BackButton(onPressed: () => Navigator.pop(context));
          } else {
            return const SizedBox.shrink(); // si no, devuelve un espacio vacío
          }
        },
      ),
    );
  }
}

