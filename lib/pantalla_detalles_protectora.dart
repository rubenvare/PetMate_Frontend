import 'package:flutter/material.dart';
import 'package:flutter_proyecto/http_functions.dart';
import 'package:flutter_proyecto/singleton_user.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreenShelter extends StatefulWidget {
  
  final int id;
  final String type;

  
  const DetailScreenShelter(this.id, this.type, {super.key});
  
  @override
  State<StatefulWidget> createState() {
    return DetailScreenShelterState();
  }
  
}

class DetailScreenShelterState extends State<DetailScreenShelter> {
  Map<String, dynamic> content = {};
  @override
  void initState(){
    super.initState();

    if(widget.type == "A"){
      dynamic dataAdopter = {
        "user_id":widget.id,
        "type": UserSession().type,
      };
      initAsync(dataAdopter);
    } else {
      dynamic dataAnimal = {
        "animal_id":widget.id
      };
      initAsync(dataAnimal);
    }

  }
  Future<void> initAsync(data) async {
    Map<String, dynamic> response = widget.type == "A" ? await getProfileInfo(data) : await getPetDetails(data);

    setState(() {
      response.forEach((key, value) {
        content[key] = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return widget.type == "A" ? ContentAnimal(content) : ContentAdopter(content);
  }
}


class ContentAdopter extends StatelessWidget{

  final Map<String, dynamic> content;
  ContentAdopter(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 40.0,),
          Text('DATOS DEL ADOPTANTE'
              , style: GoogleFonts.quicksand(fontSize: 25.0, fontWeight: FontWeight.w900)),
          SizedBox(height: 20.0,),
          Row(children: [
            SizedBox(width: 10.0),
            Icon(Icons.mail_outline),
            SizedBox(width: 10.0),
            Text(content['email']
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],),

          SizedBox(height: 20.0,),

          Row(children: [
            SizedBox(width: 10.0),
            Icon(Icons.person_outline),
            SizedBox(width: 10.0),
            Text(content['username']
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],),

          SizedBox(height: 20.0,),
          Row( children: [
            SizedBox(width: 10.0),
            Icon(Icons.house_outlined),
            SizedBox(width: 10.0),
            Text('${content["living_space"]} m2'
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
          ),
          SizedBox(height: 20.0,),
          Row( children: [
            SizedBox(width: 10.0),
            Icon(Icons.access_time),
            SizedBox(width: 10.0),
            Text('${content["available_time"]} h'
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
          ),
          SizedBox(height: 20.0,),
          Row( children: [
            SizedBox(width: 10.0),
            Icon(Icons.balcony_outlined),
            SizedBox(width: 10.0),
            Text('${content["available_time"]} h'
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
          ),
          SizedBox(height: 20.0,),
          Row( children: [
            SizedBox(width: 10.0),
            Icon(Icons.grass_outlined),
            SizedBox(width: 10.0),
            Text('${content["available_time"]} h'
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
          ),
          SizedBox(height: 20.0,),
          Row( children: [
            SizedBox(width: 10.0),
            Icon(Icons.pets_outlined),
            SizedBox(width: 10.0),
            Text('${content["available_time"]} h'
                , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
          ),
          SizedBox(height: 20.0,),
          Column(children: [
            Row( children: [
              SizedBox(width: 10.0),
              Icon(Icons.description_outlined),
              Text('  '),
              Expanded(child: Text(content['description']
                  , style: GoogleFonts.quicksand(fontSize: 20.0, fontWeight: FontWeight.bold)))

            ],),
          ],),
        ]
    );
  }
}

class ContentAnimal extends StatelessWidget {
  ContentAnimal(Map<String, dynamic> content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
