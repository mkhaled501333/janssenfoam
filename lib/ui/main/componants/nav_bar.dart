import 'package:flutter/material.dart';
import '../../../controllers/main_controller.dart';
import '../main_viewModel.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final MainViewModel vm = MainViewModel();

  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder: (context, myType, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: myType.currentIndex,
          backgroundColor: const Color(0xff1A3D63),
          selectedItemColor: const Color(0xffffffff),
          unselectedItemColor: const Color.fromARGB(255, 24, 159, 248),
          selectedIconTheme: const IconThemeData(),
          unselectedIconTheme: const IconThemeData(),
          selectedLabelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onTap: (value) {
            myType.changecurrenIndexogbuttonNav(value);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'الاعدادات',
              icon: Icon(Icons.settings),
            ),
            BottomNavigationBarItem(
              label: 'التقارير',
              icon: Icon(Icons.sticky_note_2_outlined),
            ),
            BottomNavigationBarItem(
              label: 'الرئسية',
              icon: Icon(Icons.home),
            ),
          ],
        );
      },
    );
  }
}
