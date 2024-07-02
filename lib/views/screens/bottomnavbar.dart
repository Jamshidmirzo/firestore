import 'package:flutter/material.dart';
import 'package:new_firebase/views/screens/homepage.dart';
import 'package:new_firebase/views/screens/leaderboardpage.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int currentindex = 0;
  List<Widget> screens = [Homepage(), Leaderboardpage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.deepPurple,
        onTap: (value) {
          currentindex = value;
          setState(() {});
        },
        backgroundColor: const Color.fromARGB(255, 9, 28, 49),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.quiz_outlined,
              ),
              label: 'Quizes'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard,
              ),
              label: 'Leaderboard'),
        ],
      ),
      body: screens[currentindex],
    );
  }
}
