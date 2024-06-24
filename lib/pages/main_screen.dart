import 'package:flutter/material.dart';
import 'package:volunteer/models/Usuario.dart';
import 'package:volunteer/page_reload_notifier.dart';
import '../widgets/custom_navigation_bar.dart';
import 'my_home_page.dart';
import 'profile_page.dart';
import 'chat_page.dart';

class MainScreen extends StatefulWidget {
  final Usuario usuario;
  MainScreen({Key? key, required this.usuario}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _selectedIndex = 1;
  late List<Widget> _pages;
  late PageReloadNotifier
      _pageReloadNotifier; // Crear una instancia de PageReloadNotifier

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageReloadNotifier =
        PageReloadNotifier(); // Inicializar PageReloadNotifier
    _updatePages();

    // Escuchar cambios en PageReloadNotifier
    _pageReloadNotifier.addListener(_handleUserUpdate);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageReloadNotifier.removeListener(
        _handleUserUpdate); // Usar la instancia para eliminar el listener
    super.dispose();
  }

  void _updatePages() {
    // Reconstruir la lista de páginas con el usuario actualizado
    _pages = [
      ProfilePage(usuario: widget.usuario, onChangesSaved: _updatePages),
      MyHomePage(usuario: widget.usuario),
      ChatPage(usuario: widget.usuario),
    ];
  }

  void _handleUserUpdate() {
    setState(() {
      _updatePages(); // Actualizar las páginas cuando el usuario cambie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
