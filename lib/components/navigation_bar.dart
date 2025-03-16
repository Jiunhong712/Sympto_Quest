import 'package:flutter/material.dart';
import '../screens/chat/chatbot_page.dart';
import '../screens/rewards/rewards_page.dart';
import '../screens/discover/discover_page.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ChatPage(),
    RewardsPage(),
    DiscoverPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFFD8D9),
        selectedItemColor: const Color(0xFFD00F00),
        unselectedItemColor: Colors.black26,
        currentIndex: _currentIndex,
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
