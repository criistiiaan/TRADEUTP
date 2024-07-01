import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/screen/messages/conversation.dart';

class DetailsItemPage extends StatefulWidget {
  final int idItem;

  const DetailsItemPage({Key? key, required this.idItem}) : super(key: key);

  @override
  State<DetailsItemPage> createState() => _DetailsItemPageState();
}

class _DetailsItemPageState extends State<DetailsItemPage> {
  
  late Future<List<Map<String, dynamic>>> _itemsFuture;
  late Future<List<Map<String, dynamic>>> _userFuture;
  String name_seller = '';

  @override
  void initState() {
    super.initState();
    _loadItem(); // Cargar artículo al iniciar la pantalla
  }

  Future<void> _loadItem() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getItemsId(widget.idItem); // Usar getItemById en lugar de getItemsId
      _userFuture = DatabaseHelper().getUserByItem(widget.idItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
          ),
          iconSize: 50,
          color: colormainColor,
        ),
        title: Text(
          'Detalles',
          style: TextStyle(color: colormainColor, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Acción para manejar favoritos
            },
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: colormainColor),
              ),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: colormainColor, // Color del icono de corazón
                  size: 30, // Tamaño del icono
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontró el artículo'));
          } else {
            List<Map<String, dynamic>> items = snapshot.data!;
            Map<String, dynamic> item = items[0];
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colordetailedItemBackground, // Fondo verde
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: item['image'].isNotEmpty
                        ? Image.file(
                            File(item['image']),
                            fit: BoxFit.cover,
                          )
                        : Placeholder(), // Placeholder en caso de no haber imagen
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                    item['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: colormainColor),
                  ),
                  Text(
                    '\$${item['price']*1.00}',
                    style: TextStyle(fontSize: 36, color: colormainColor, fontWeight: FontWeight.bold),
                  ),
                  ],),
                  
                  SizedBox(height: 8.0),
                  Container (
                    height: 100,
                    child: Text(
                    item['description'],
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),),
                  SizedBox(height: 8.0),
                  Text("Información del vendedor", style: TextStyle(color: colormainColor, fontWeight: FontWeight.bold,fontSize: 16 ),)
                  ,Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [                     
                       Expanded(
                        flex: 10,
                        child:Container( 
                          alignment: Alignment.topLeft,
                          
                          child:
                        Icon(Icons.account_circle,size:64 ),),),

                      Expanded(
                        flex: 25,

                        child: 
                          FutureBuilder<List<Map<String, dynamic>>>(
                          future: _userFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No se encontró el nombre del usuario'));
                            } else {
                              List<Map<String, dynamic>> users = snapshot.data!;
                              Map<String, dynamic> user = users[0];
                              name_seller = '${user['name']} ${user['surname']}';
                              print(name_seller);
                              return Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[Text( name_seller),
                      Text(user['facultad'],)]);}}),
                      
                    ),

                      GestureDetector(
                        onTap: () {
                          
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                        ConversationPage(id: item['fromUsers'],name:name_seller)),);
                      
                        },
                        child: Column(children: [
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50], // Fondo verde claro
                              borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                              border: Border.all(
                                color: Colors.green, // Color del borde
                                width: 2.0, // Ancho del borde
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espaciado interno
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // Ajustar al contenido
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                  color: Colors.green[900], // Color del icono
                                  size: 30.0, // Tamaño del icono
                                ),
                                SizedBox(width: 8.0), // Espacio entre el icono y el texto
                                Text(
                                  'Hola, ¿Está \ndisponible?',
                                  style: TextStyle(
                                    color: Colors.green[900], // Color del texto
                                    fontSize: 11.0, // Tamaño del texto
                                  ),
                                  
                                ),
                              ],
                            ),
                          ),
      
                        ],)
                      ],)
                  ),],),
                  ),
                  SizedBox(height: 24,),
                  Text("Otras de sus publicaciones",style: TextStyle(color: colormainColor, fontWeight: FontWeight.bold,fontSize: 16 ))
                  ,Text("El usuario no tiene más publicaciones", style: TextStyle(color:colorfaintColor, fontSize: 12),)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
