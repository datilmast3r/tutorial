import 'package:flutter/material.dart';
import 'package:volunteer/models/Usuario.dart';
import 'package:volunteer/models/chat_user.dart';
import '../widgets/custom_navigation_bar.dart';
import 'my_home_page.dart'; // Asegúrate de tener esta página
import 'profile_page.dart'; // Asegúrate de tener esta página
import 'chat_page.dart'; // Asegúrate de tener esta página

class MainScreen extends StatefulWidget {
  final Usuario usuario;
  MainScreen({Key? key, required this.usuario}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    ProfilePage(),
    MyHomePage(),
    ChatPage(
        user: ChatUser(
      image:
          'https://imgs.search.brave.com/9q4Z617XjNLgmF-_S_FSUd24pGS_W1yMIuCkNJagsd0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4x/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvaGVyb2ljb25z/LXVpLzI0L3VzZXIt/MTI4LnBuZw',
      about: 'I love coding and exploring new technologies.',
      name: 'Jane Doe',
      createdAt: '2023-04-01T12:00:00Z',
      isOnline: true,
      id: 'user123',
      lastActive: '2023-04-15T15:30:00Z',
      email: 'jane.doe@example.com',
      pushToken: 'exPushToken123',
    )),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _pages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Actualiza la pestaña seleccionada
          });
        },
        // Asegúrate de configurar tu CustomNavigationBar correctamente
      ),
    );
  }
}
