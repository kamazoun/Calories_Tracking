import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/utils/global.dart';
import 'package:simple_calorie_app/views/calories_consumption_stats.dart';
import 'package:simple_calorie_app/views/create_food_entry.dart';
import 'package:simple_calorie_app/views/home.dart';

import 'main_drawer.dart';

class BNBPV extends StatefulWidget {
  const BNBPV({Key? key}) : super(key: key);

  @override
  _BNBPVState createState() => _BNBPVState();
}

class _BNBPVState extends State<BNBPV> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(currentIndex),
      appBar: AppBar(
        title: const Text(kAppTitle),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: changePage,
        children: const [
          Home(),
          CalorieConsumptionStats(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Consumption', icon: Icon(Icons.history)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const CreateFoodEntry()),
      ),
    );
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(seconds: 2), curve: Curves.easeOutCubic);
    });
  }

  Widget? _buildDrawer(currentPage) {
    if (currentPage == 0) {
      return const MainDrawer();
    } else {
      return null;
    }
  }
}
