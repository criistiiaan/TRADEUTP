
import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/asset/userAccount.dart';
import 'package:tradeutp/screen/messages/conversation.dart';
import '/asset/colors.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = DatabaseHelper().getAllChats(userAccount[2] as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 29, right: 20, top: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      "Mensajes",
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
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 2), // Ajustado el margen inferior
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
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _itemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay chats'));
                } else {
                  List<Map<String, dynamic>> chats = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10), // Añadido padding para mayor separación
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return ChatMessengerDesign(
                        idVendedor: chats[index]['toUsers'],
                        chatId: chats[index]['id'],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessengerDesign extends StatefulWidget {
  final int idVendedor;
  final int chatId;

  const ChatMessengerDesign({Key? key, required this.idVendedor, required this.chatId}) : super(key: key);

  @override
  State<ChatMessengerDesign> createState() => _ChatMessengerDesignState();
}

class _ChatMessengerDesignState extends State<ChatMessengerDesign> {
  late Future<Map<String, dynamic>> _lastMessageFuture;
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    _lastMessageFuture = DatabaseHelper()
        .getLastMessagesForChat(widget.chatId)
        .then((value) => convertListToMap(value));
    _userFuture = DatabaseHelper()
        .getSelectUsers(widget.idVendedor)
        .then((value) => convertListToMap(value));
  }

  Future<Map<String, dynamic>> convertListToMap(List<Map<String, dynamic>> list) async {
    if (list.isNotEmpty) {
      return list.first;
    } else {
      throw Exception('La lista está vacía');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait([_lastMessageFuture, _userFuture]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay datos disponibles'));
        } else {
          List<Map<String, dynamic>> datos = snapshot.data!;

          if (datos.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          }

          Map<String, dynamic> lastMessage = datos[0];
          Map<String, dynamic> users = datos[1];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0), // Ajusta este valor según sea necesario
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 34, 72, 33),
                child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              title: Text(
                '${users['name']} ${users['surname']}',
                style: TextStyle(color: Color.fromARGB(255, 34, 72, 33)),
              ),
              subtitle: Text(
                lastMessage['mensaje'],
                style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),
              ),
              trailing: Text(
                lastMessage['Time'],
                style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),
              ),
              selected: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationPage(
                      id: widget.chatId,
                      name: '${users['name']} ${users['surname']}',
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}