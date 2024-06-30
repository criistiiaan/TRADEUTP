import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

// clase para la ventana de favoritos
class _FavoritePageState extends State<FavoritePage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos', style: TextStyle(color: Color.fromARGB(255, 34, 72, 33),fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 34, 72, 33)),
            onPressed: () {
              // Acción para el botón de perfil
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.es%2Ficono-gratis%2Ftransparente_5376400&psig=AOvVaw32FvACLSk4IzE9P2vTwzKL&ust=1719707442535000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLCNlczH_4YDFQAAAAAdAAAAABAE'),
                      title: Text('Libro de Cálculo'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lorem ipsum dolor sit amet, consectetur adipisc...'),
                          SizedBox(height: 5),
                          Text(
                            'Venta \$0.00',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Vendedor'),
                        ],
                      ),
                      trailing: Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


