import 'package:flutter/material.dart';
import 'package:flutter_proyecto/http_functions.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  int pet_id;
  DetailScreen(this.pet_id, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState(pet_id);
}

class _DetailScreenState extends State<DetailScreen> {
  // true = animal, false = protectora
  bool animal_o_protectora = true;
  Map<String, dynamic> details = {};
  Map<String, dynamic> shelter = {};
  bool dataLoaded = false;
  int pet_id;
  Image? shelterPicture;
  String? color, size, age;

  _DetailScreenState(this.pet_id);

  @override
  void initState() {
    super.initState();
    initAsync(pet_id);
  }

  void initAsync(int pet) async {
    Map<String, dynamic> response = await getPetDetails({'animal_id': pet});

    setState(() {
      details['name'] = response['name'];
      details['species'] = response['species'];
      details['color'] = response['color'];
      details['size'] = response['size'];
      details['age'] = response['age'];
      details['description'] = response['description'];
      details['image'] = response['image'];
      details['shelter_id'] = response['shelter_id'];
      details['status'] = response['status'];

      switch(details['color']) {
        case 0:
          color = 'Claro';
          break;
        case 1:
          color = 'Neutro';
          break;
        case 2:
          color = 'Oscuro';
          break;
        default:
          color = '';
          break;
      }

      switch(details['size']) {
        case 0:
          size = 'Pequeño';
          break;
        case 1:
          size = 'Mediano';
          break;
        case 2:
          size = 'Grande';
          break;
        default:
          size = '';
          break;
      }

      dataLoaded = true;
    });
    Map<String, dynamic> shelter_info = await getProfileInfo({'user_id': details['shelter_id'], 'type': 'S' });
    setState(() {
      shelter['email'] = shelter_info['email'];
      shelter['username'] = shelter_info['username'];
      shelter['photo'] = shelter_info['photo'];
      shelter['description'] = shelter_info['description'];
      shelter['phone'] = shelter_info['phone'];
      shelter['location'] = shelter_info['location'];
      shelterPicture = getImage(shelter['photo']);
    });
  }

  void changeStatus(String status) {
    setState(() {
      if (animal_o_protectora) {
        if (status == 'S') {
          animal_o_protectora = !animal_o_protectora;
        }
      } else {
        if (!animal_o_protectora) {
          if (status == 'A') {
            animal_o_protectora = !animal_o_protectora;
          }
        }
      }

    });
  }

  Widget PetMateLoading() {
    return Container(
      color: Color(0xFFC4A484),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.pets,
                size: 72,
                color: Colors.brown,
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.brown,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetMateAppBar(),
      body: (dataLoaded == false) ? PetMateLoading() :
      Container(
          width: double.infinity,
          color: Color(0xFFC4A484),
          child: Column(

            children: [
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => changeStatus('A'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown,),
                    child: Text(
                      'ANIMAL',
                      style: GoogleFonts.quicksand(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => changeStatus('S'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown,),
                    child: Text(
                      'PROTECTORA',
                      style: GoogleFonts.quicksand(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0
                      ),
                    ),
                  ),
                ],
              ),

              animal_o_protectora == true ? Column(
                children: [
                  SizedBox(height: 50.0,),
                  Text('DATOS DE LA MASCOTA'
                      , style: GoogleFonts.quicksand(
                          fontSize: 25.0, fontWeight: FontWeight.w900)),
                  SizedBox(height: 40.0,),
                  Row( children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.badge_outlined),
                    Text('  Nombre:  '
                        , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.w900)),

                    Text('${details['name']}'
                        , style: GoogleFonts.quicksand(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 20.0,),
                  Row( children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.pets_outlined),
                    Text('  Especie:  '
                        , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.w900)),

                    Text('${details['species']}'
                        , style: GoogleFonts.quicksand(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 20.0,),
                  Row( children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.palette_outlined),
                    Text('  Color:  '
                        , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.w900)),
                    Text('${color}'
                        , style: GoogleFonts.quicksand(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 20.0,),
                  Row( children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.straighten_outlined),
                    Text('  Tamaño:  '
                        , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.w900)),
                    Text('${size}'
                        , style: GoogleFonts.quicksand(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 20.0,),
                  Row( children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.info_outlined),
                    Text('  Edad:  '
                        , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.w900)),
                    Text('${details['age']} años'
                        , style: GoogleFonts.quicksand(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],),
                  SizedBox(height: 20.0,),
                  Column(children: [
                    Row( children: [
                      SizedBox(width: 10.0),
                      Icon(Icons.description_outlined),
                      Text('  '),
                      Expanded(child: Text('${details['description']}'
                          , style: GoogleFonts.quicksand(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),)

                    ],),
                  ],)
                ],
              )
                  :
              SingleChildScrollView(child: Column(
                  children: [
                    SizedBox(height: 40.0,),
                    Text('DATOS DE LA PROTECTORA'
                        , style: GoogleFonts.quicksand(fontSize: 25.0, fontWeight: FontWeight.w900)),
                    SizedBox(height: 20.0,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      // cuando se añadan fotos de protectoras al server: child: Center(child: shelterPicture),
                      child: getImage('${shelter['photo']}'),
                    ),
                    SizedBox(height: 20.0,),
                    Row(children: [
                      SizedBox(width: 10.0),
                      Icon(Icons.mail_outline),
                      SizedBox(width: 10.0),
                      Text('${shelter['email']}'
                          , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],),

                    SizedBox(height: 20.0,),

                    Row(children: [
                      SizedBox(width: 10.0),
                      Icon(Icons.person_outline),
                      SizedBox(width: 10.0),
                      Text('${shelter['username']}'
                          , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],),

                    SizedBox(height: 20.0,),
                    Column(children: [
                      Row( children: [
                        SizedBox(width: 10.0),
                        Icon(Icons.description_outlined),
                        Text('  '),
                        Expanded(child: Text('${shelter['description']}'
                            , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)))

                      ],),
                    ],),

                    SizedBox(height: 20.0,),

                    Row( children: [
                      SizedBox(width: 10.0),
                      Icon(Icons.phone_outlined),
                      SizedBox(width: 10.0),
                      Text('${shelter['phone']}'
                          , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ]
              ))
            ],
          )
      ),
    );
  }
}
