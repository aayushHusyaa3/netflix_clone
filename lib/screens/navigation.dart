import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/favorite.dart';
import 'package:flutter_application_2/screens/homePage.dart';
import 'package:flutter_application_2/screens/profile.dart';
import 'package:flutter_application_2/screens/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List navigationPageList = [
    HomePage(),
    FavoritePage(),
    SearchPage(),
    ProfilePage(),
  ];
  int currentIndex = 0;

  void onNavigationBarTapped(int index) {
    setState(() {
      currentIndex = index;
      log(currentIndex.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationPageList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.red,
        currentIndex: currentIndex,
        iconSize: 30.h,

        onTap: onNavigationBarTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favrite"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
        ],
      ),
    );
  }
}
