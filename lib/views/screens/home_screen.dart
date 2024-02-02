import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  void onChangedPage(int page) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(label: '', icon: CustomIcon()),
          BottomNavigationBarItem(
            label: 'Messages',
            icon: Icon(
              Icons.message,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ],
      ),
      body: pages[_pageIndex],
    );
  }
}
