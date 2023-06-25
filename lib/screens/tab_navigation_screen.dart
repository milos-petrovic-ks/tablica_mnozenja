import 'package:flutter/material.dart';
import '../screens/trophies_screen.dart';
import '../utils/globals.dart';
import '../widgets/appbar_widget.dart';
import '../screens/question_screen.dart';
import '../screens/statistics_screen.dart';
import '../screens/home_screen.dart';

class TabNavigationScreen extends StatefulWidget {
  TabNavigationScreen({super.key}) {
    if (Globals.loggedPerson.numbersToPractice.isEmpty) {
      Globals.loggedPerson.numbersToPractice = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }
  }
  @override
  State<TabNavigationScreen> createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationScreen> {
  int _selectedIndex = 0;
  static List<Widget> _tabContent = [];
  @override
  initState() {
    super.initState();
    _tabContent = [
      Globals.showPracticeScreen ? const Question() : const Home(),
      const Statistics(),
      const Trophies(),
    ];
  }

  String _appBarTitle() {
    final List<String> appBarTitles = ["Početak", "Rezultati", "Nagrade"];
    if (_selectedIndex == 0 && Globals.showPracticeScreen) {
      return "Zadaci";
    }
    return appBarTitles[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarCommon(
          text: _appBarTitle(),
          isLogOutButton: _selectedIndex == 0 && !Globals.showPracticeScreen,
          hasTabs: _selectedIndex == 2,
          isLevel2: false,
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.fill),
          ),
          child: _tabContent.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue[50],
            elevation: 0.0,
            unselectedFontSize: 14,
            selectedFontSize: 14,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.trending_up,
                  size: 24,
                ),
                label: 'Vežbanje',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.task_outlined,
                  size: 24,
                ),
                label: 'Rezultati',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.military_tech_outlined,
                  size: 24,
                ),
                label: 'Nagrade',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[900],
            onTap: (index) {
              if (Globals.waitForAnimation) return;
              setState(
                () {
                  _selectedIndex = index;
                },
              );
            }),
      ),
    );
  }
}
