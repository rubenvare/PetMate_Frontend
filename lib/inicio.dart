import 'package:flutter/material.dart';
import 'package:flutter_proyecto/pantalla_busqueda.dart';
import 'package:flutter_proyecto/pantalla_protectora.dart';
import 'package:flutter_proyecto/router.dart';
import 'package:flutter_proyecto/routing_constants.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/http_functions.dart';

import 'app_localizations.dart';



class InicioSesion extends StatefulWidget {
  @override
  State<InicioSesion> createState() => InicioSesionState();
}

class InicioSesionState extends State<InicioSesion> {
  final formKey = GlobalKey<FormState>();
  bool errorMailRegExp = false;
  bool errorMailEmpty = false;
  bool errorPassword = false;
  bool obscurePassword = true;
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
                  AppLocalizations.of(context).translate('mensajeBienvenida'),
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

                            labelText: AppLocalizations.of(context).translate('correo'),
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
                              return AppLocalizations.of(context).translate('campoObligatorio');
                            }
                            else {
                              if (!coincideMail.hasMatch(value)) {
                                setState(() {
                                  errorMailRegExp = true;
                                });
                                return AppLocalizations.of(context).translate('formatoObligatorio');
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
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.brown)
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                              ),
                              labelText: AppLocalizations.of(context).translate('contrasena'),
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
                              return AppLocalizations.of(context).translate('campoObligatorio');
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
                                if(UserSession().type == "A"){
                                  DogSearchScreen search = DogSearchScreen();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => search,
                                    ),
                                  );
                                } else {
                                  PantallaProtectoraItems shelter = PantallaProtectoraItems("null", "null");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => shelter,
                                    ),
                                  );
                                }
                              } else {
                                openDialog(context);
                                formKey.currentState?.reset();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                            ),
                            child: Text(
                              AppLocalizations.of(context).translate('login'),
                                style: GoogleFonts.quicksand(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0,

                                ))),
                        SizedBox(height: 50),
                        Text(AppLocalizations.of(context).translate('noCuenta'),
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
                                AppLocalizations.of(context).translate('registro'),
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

  void openDialog(BuildContext context) async{
    final localizations = AppLocalizations.of(context);
    await localizations.load(); // Await the load method
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(localizations.translate('usuarioNo')),
          actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'))
      ],
    ));
  }
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

