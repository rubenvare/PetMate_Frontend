import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_proyecto/inicio.dart';
import 'http_functions.dart';
import 'router.dart';

class PantallaFiltro extends StatefulWidget {
  Map<String, dynamic> filters_from_previous_screen = {};
  PantallaFiltro(this.filters_from_previous_screen, {super.key});
  @override
  State<PantallaFiltro> createState() => PantallaFiltroState(filters_from_previous_screen);
}

class PantallaFiltroState extends State<PantallaFiltro> {
  List<String> years = [];
  List<String> months = [];
  String? selectedMonth, selectedYear;
  Map<String, dynamic> filters_from_previous_screen = {};
  Map<String, dynamic> filters_from_current_screen = {};
  TextEditingController _controller = TextEditingController();

  PantallaFiltroState(this.filters_from_previous_screen);

  @override
  void initState() {
    super.initState();
    selectedYear = "";
    selectedMonth = "";
    years.add("Sin preferencia");
    months.add("Sin preferencia");
    // inicializar listas de año y mes
    for (int i = DateTime.now().year; i >= DateTime.now().year - 25; i--) {
      years.add(i.toString());
    }

    for (int i = 1; i < 13; i++) {
      if (i < 10) {
        months.add('0$i');
      } else {
        months.add(i.toString());
      }
    }

    filters_from_current_screen = {...filters_from_previous_screen};

    // Si ya había algo en los filtros de edad previamente, lo mantenemos en la pantalla de filtros
    if (filters_from_previous_screen['birth'] != null) {
      selectedMonth = filters_from_previous_screen['birth'].split('-')[0];
      selectedYear = filters_from_previous_screen['birth'].split('-')[1];
    }

    switch(filters_from_current_screen['color']) {
      case 0:
        filters_from_current_screen['color'] = 'Claro';
        break;
      case 1:
        filters_from_current_screen['color'] = 'Neutro';
        break;
      case 2:
        filters_from_current_screen['color'] = 'Oscuro';
        break;
      default:
        filters_from_current_screen['color'] = 'Sin preferencia';
        break;
    }

    switch(filters_from_current_screen['size']) {
      case 0:
        filters_from_current_screen['size'] = 'Pequeño';
        break;
      case 1:
        filters_from_current_screen['size'] = 'Mediano';
        break;
      case 2:
        filters_from_current_screen['size'] = 'Grande';
        break;
      default:
        filters_from_current_screen['size'] = 'Sin preferencia';
        break;
    }
  }

  PreferredSizeWidget FilterScreenAppBar(BuildContext context) {
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
            return BackButton(onPressed: () => Navigator.pop(context, [filters_from_previous_screen, false]));
          } else {
            return const SizedBox.shrink(); // si no, devuelve un espacio vacío
          }
        },
      ),
    );
  }

  void _textToNumbers() {
    // de cara a devolverle el array de filtros cuando hagamos el pop(), los valores tienen que ser numéricos en caso de
    // color, y tamaño
    switch(filters_from_current_screen['color']) {
      case 'Claro':
        filters_from_current_screen['color'] = 0;
        break;
      case 'Neutro':
        filters_from_current_screen['color'] = 1;
        break;
      case 'Oscuro':
        filters_from_current_screen['color'] = 2;
        break;
      default:
        filters_from_current_screen['color'] = null;
        break;
    }

    switch(filters_from_current_screen['size']) {
      case 'Pequeño':
        filters_from_current_screen['size'] = 0;
        break;
      case 'Mediano':
        filters_from_current_screen['size'] = 1;
        break;
      case 'Grande':
        filters_from_current_screen['size'] = 2;
        break;
      default:
        filters_from_current_screen['size'] = null;
        break;
    }

    // tratamos el string de edad (birth)
    if (selectedYear == "" || selectedMonth == "" || selectedYear == "Sin preferencia" || selectedMonth == "Sin preferencia") {
      filters_from_current_screen['birth'] = null;
    } else {
      if (selectedYear != "" && selectedMonth != "") {
        filters_from_current_screen['birth'] = "${selectedMonth}-${selectedYear}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterScreenAppBar(context),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFC4A484),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                'FILTRADO DE MASCOTA',
                                style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ]),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)
                              ),

                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Especie',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                dropdownColor: Colors.brown,
                                onChanged: (String? changedValue) {
                                  filters_from_current_screen['species'] = changedValue!;
                                  setState(() {
                                    filters_from_current_screen['species'];
                                  });
                                },
                                isExpanded: true,
                                style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                value: filters_from_current_screen['species'] == null ? 'Sin preferencia' : filters_from_current_screen['species'],
                                items: <String>["dog", "cat", "bird", "Sin preferencia"]
                                    .map((item) => DropdownMenuItem(
                                  child: Text(item),
                                  value: item,

                                ))
                                    .toList(),
                              )
                          ),
                          const SizedBox(height: 20),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(

                                  border: Border.all(
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)
                              ),

                              child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Color',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: Colors.brown,
                                  onChanged: (String? changedValue) {
                                    filters_from_current_screen['color'] = changedValue!;
                                    setState(() {
                                      filters_from_current_screen['color'];
                                    });
                                  },
                                  isExpanded: true,
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: filters_from_current_screen['color'] == null ? 'Sin preferencia' : filters_from_current_screen['color'],
                                  items: <String>["Claro", "Neutro", "Oscuro", "Sin preferencia"]
                                      .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  ))
                                      .toList(),
                            )
                          ),
                          const SizedBox(height: 20),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(

                                  border: Border.all(
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(5)
                              ),

                              child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Tamaño',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: Colors.brown,
                                  onChanged: (String? changedValue) {
                                    filters_from_current_screen['size'] = changedValue!;
                                    setState(() {
                                      filters_from_current_screen['size'];
                                    });
                                  },
                                  isExpanded: true,
                                  style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: filters_from_current_screen['size']  == null ? 'Sin preferencia' : filters_from_current_screen['size'],
                                  items: <String>["Pequeño", "Mediano", "Grande", "Sin preferencia"]
                                      .map((item) => DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  ))
                                      .toList(),)
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(5),),
                            child:
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Mes de nacimiento',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.brown,
                              onChanged: (String? changedValue) {
                                selectedMonth = changedValue!;
                                setState(() {
                                  selectedMonth;
                                });
                              },
                              isExpanded: true,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              value: selectedMonth == "" ?  'Sin preferencia' : selectedMonth,
                              items: months
                                  .map((item) => DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(5),),
                            child:
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Año de nacimiento',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                              dropdownColor: Colors.brown,
                              onChanged: (String? changedValue) {
                                selectedYear = changedValue!;
                                setState(() {
                                  selectedYear;
                                });
                              },
                              isExpanded: true,
                              style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              value: selectedYear == "" ? 'Sin preferencia' : selectedYear,
                              items: years
                                  .map((item) => DropdownMenuItem(
                                child: Text(item),
                                value: item,
                              ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              _textToNumbers();
                              Navigator.pop(context, [filters_from_current_screen, true]);
                                } ,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown),
                            child: Text(
                              'APLICAR',
                              style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}