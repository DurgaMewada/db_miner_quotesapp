import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/navigate.dart';
import 'category.dart';
import 'favourite.dart';
import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(NavigationController());

    return Scaffold(
        backgroundColor:Color(0xff060A12),
        body: Obx(() =>
            IndexedStack(index: navController.selectedIndex.value, children: [
              HomeScreen(),
              Favourite(),
              Category(),
            ])),
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            backgroundColor: Color(0xff060A12),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffF9A825),
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_vert),
                label: 'More',
              ),
            ],
          ),
        ));
  }
}