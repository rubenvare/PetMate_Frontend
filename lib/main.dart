import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  InicioSesion createState() => InicioSesion();
}

class InicioSesion extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  bool errorMailRegExp = false;
  bool errorMailEmpty = false;
  bool errorPassword = false;
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
                          obscureText: true,
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
                            return null;
                          },
                        ),

                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: (){
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Cargando')),
                              );

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
                        ElevatedButton( onPressed: () {},
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
}

class PetMateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PetMateAppBar({super.key});
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
      leading:
      const Icon(Icons.pets_rounded ),
    );
  }

}
