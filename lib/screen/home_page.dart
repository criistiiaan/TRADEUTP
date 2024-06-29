import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/screen/new_item_page.dart';
import '../asset/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String whatActiveFilter ='Para ti';

  final List<String> texts = [
    'Para ti',
    'Todo',
    'Ropa',
    'Comida',
    'Útiles',
    'Tecno',
  ];
  final List<String> opcionesFilter = [
    'Todo',
    'Todo',
    'Ropa',
    'Comida',
    'Útiles',
    'Tecnologia',
  ];
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadItems(); // Cargar items al iniciar la pantalla
  }

  Future<void> _loadItems() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getItemsType(opcionesFilter[texts.indexOf(whatActiveFilter)]);
    });
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getItemsType(opcionesFilter[texts.indexOf(whatActiveFilter)]); // Volver a cargar items
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: colorbackground,
      child:Scaffold(
        extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar

        body: Column(children: [
          Container(
            margin: const EdgeInsets.only(left:29, right:20, top: 30),
            child: Row(
            children: [
              Expanded(                
                flex: 8, 
                child: 
              Container(  
                margin: const EdgeInsets.only( top: 26 ),
                child: Text("Publicaciones", style:TextStyle(fontSize: 24, color: colormainColor, fontWeight: FontWeight.bold),
                ),
              ),),
              Expanded(                
                flex: 1,
                child: Center(
                  child: Icon(Icons.account_circle_sharp, size: 50,color: colormainColor,),
                  ),
                )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                flex: 8, // El primer elemento ocupa 3 partes del espacio total
                child: Container(      
            padding: EdgeInsets.only(top:2, left:17,bottom: 2),
            decoration: BoxDecoration(
                color: colorfaintColorBackground, // Color de fondo del container
                border: Border.all(
                  color: Color.fromARGB(0, 0, 0, 0),
                  width: 4.0, // Grosor del borde
                ),
                borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
              ),
            margin: const EdgeInsets.only(left:29, right:20, top: 5),
            child: Row(children: [
                Icon(Icons.search, size:24, color: colorfaintColor), 
                Text("Buscar", style:TextStyle(fontSize: 13, color: colorfaintColor))

            ],),
        ),),
        Expanded(

                flex: 1, // El primer elemento ocupa 3 partes del espacio total
                child:Container(                 
                  margin: const EdgeInsets.only( right:34),
                  child:Center(
                   child:Icon(Icons.filter_list, size: 27,color: colormainColor,),
                   ),
                   )
        )],
        ),
        Container(
            padding: EdgeInsets.all(0),

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: texts.map((text) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        whatActiveFilter = text;
                        print(whatActiveFilter);
                        _refreshItems();
                      });
                    },
                    child: Container (
                    padding: EdgeInsets.only(left:10,top:23,right:6, bottom:10 ),
                    child: Container(
                      padding:EdgeInsets.only(left:31,top:3,bottom:3, right:31 ),
                      decoration: BoxDecoration(
                        color: whatActiveFilter == text ? colormainColor : colorfaintColorBackground, // Color de fondo del container
                        border: Border.all(
                          color: Color.fromARGB(0, 0, 0, 0),
                          width: 4.0, // Grosor del borde
                        ),
                        borderRadius: BorderRadius.circular(30), // Esquinas redondeadas
                      ),
                      child: Center( 
                        child:Text(
                      text,
                      style: TextStyle(fontSize: 15.0, color:whatActiveFilter == text ? Colors.white:Colors.black),
                    ),),),
                  ));
                }).toList(),
              ),
            ),
          ),
        Expanded(
          child: RefreshIndicator(onRefresh: _refreshItems,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items found'));
                } else {
                  List<Map<String, dynamic>> items = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.75, // Ajusta según tu preferencia
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = items[index];
                      return GridTile(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: colorbackgroundColor,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // Cambia según tus preferencias
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Center(
                                child: item['image'].isNotEmpty
                                    ? Image.file(
                                        File(item['image']),
                                        fit: BoxFit.cover,
                                      )
                                    : Placeholder(), // Placeholder en caso de no haber imagen
                              ),),
                              
                              SizedBox(height: 8.0),
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(children: [
                              Text(item['description'], style: TextStyle(fontSize: 13, color: Colors.black),),
                              Text('\$${item['price']}', style: TextStyle(fontSize:13,color:colorfaintColor )),
                              ]),
                              Icon(Icons.arrow_circle_right_outlined, size:33)])
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
    
        ],),
        floatingActionButton: ClipRRect(
          borderRadius:BorderRadius.circular(200),
          child:FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewItemPage()),
            );
          },
          backgroundColor: colormainColor,
          
          child: const Icon(Icons.add, color:Colors.white, ),

        ),),
        
      
      )
    );
  }
}
