import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/screen/DetailsItemPage.dart';
import 'package:tradeutp/widget/floatingActionButtonRoute.dart';
import '../asset/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String whatActiveFilter ='Para ti';
  final TextEditingController busquedaController = TextEditingController();
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
    'Tecnología',
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

    return Scaffold(
      floatingActionButton: FloatingActionButtonRoute(),
      
      body: Scaffold(

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
                flex: 2,
                child: Center(
                  child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(

              height: 100,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                
                border: Border.all(
                  color: colormainColor, // Color del borde
                  width: 1.0, // Ancho del borde
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3), // Espaciado entre el ícono y el borde
                child: Icon(Icons.person, color: colormainColor,size: 42,),
              ),
            ),
          ),
                  ),
                )
            ],
          ),
        ),
        Container( 
          margin: EdgeInsets.only(left:30, right:30),
          child:Row(
          children: [
            Expanded(
              flex: 10,
              child: TextField(
                
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,),
                  hintText: 'Buscar',
                  filled: true,
                  fillColor: colorfaintColorBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1),
                ),
              ),),
            Expanded(
              flex:2,
              child:Icon(Icons.filter_list, size: 32,) ,)
              
            
                 ],
        ),),
        Container(
          margin: EdgeInsets.only(top: 5), // Aquí agregamos un margen superior de 20
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [SizedBox(width: 16,), ...texts.map((text) {
                return GestureDetector(
                   onTap: () {
                    setState(() {
                      whatActiveFilter = text;
                      print(whatActiveFilter);
                      _refreshItems();
                    });
                  },
                  child: Container (
                  padding: EdgeInsets.only(left:10,top:23,right:1, bottom:10 ),
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
              }).toList(),]
            ),
          ),
        ),
        SizedBox(height: 20), // Añadimos una separación de 20 entre el filtro y los contenedores
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
                  return Center(child: Text('No hay articulos publicados'));
                } else {
                  List<Map<String, dynamic>> items = snapshot.data!;
                  return  GridView.builder(
                    padding: EdgeInsets.only(left:29, right:25, bottom:21),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 0.75, // Ajusta según tu preferencia
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = items[index];
                      return GridTile(
                        child: 
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailsItemPage(idItem:item['id'])),
                            );
                            });
                          },
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
                              Text(item['type'], style: TextStyle(fontSize: 13, color: Colors.black),),
                              Text('\$${item['price']}', style: TextStyle(fontSize:13,color:Colors.black, fontWeight: FontWeight.w100 )),
                              ]),
                              Icon(Icons.arrow_circle_right_outlined, size:40, weight: 345,)])
                            ],
                          ),
                        ),
                      ),);
                    },
                  );
            }
              },
            ),
          ),
        ),
        ],)
        
        
      
      )
    );
  }
}
