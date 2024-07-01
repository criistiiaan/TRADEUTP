
import 'package:flutter/material.dart';
import '../asset/colors.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(left: 29, right: 20, top: 30),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  margin: const EdgeInsets.only(top: 26),
                  child: Text(
                    "Favoritos",
                    style: TextStyle(
                      fontSize: 24,
                      color: colormainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
                        child: Icon(
                          Icons.person,
                          color: colormainColor,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar',
                    filled: true,
                    fillColor: colorfaintColorBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.filter_list,
                  size: 32,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10), // Espacio reducido para mover el mensaje más arriba
        Center(
          child: Text(
            'Aún no has agregado favoritos',
            style: TextStyle(
              color: Color.fromARGB(255, 131, 131, 131),
              fontSize: 18, // Tamaño del texto ajustado
              fontWeight: FontWeight.w500, // Peso de la fuente ajustado
            ),
            textAlign: TextAlign.center, // Centrando el texto
          ),
        ),
      ]),
    );
  }
}


