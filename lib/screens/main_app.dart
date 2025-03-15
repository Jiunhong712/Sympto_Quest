import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/chat_page.dart';
import '../screens/rewards_page.dart';
import '../screens/discover_page.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    RewardsPage(),
    DiscoverPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
