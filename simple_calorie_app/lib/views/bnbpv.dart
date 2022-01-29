import 'package:flutter/material.dart';
import 'package:simple_calorie_app/utils/global.dart';
import 'package:simple_calorie_app/views/calories_consumption_stats.dart';
import 'package:simple_calorie_app/views/home.dart';

import 'main_drawer.dart';

class BNBPV extends StatefulWidget {
  const BNBPV({Key? key}) : super(key: key);

  @override
  _BNBPVState createState() => _BNBPVState();
}

class _BNBPVState extends State<BNBPV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: PageView(
        children: const [Home(), CalorieConsumptionStats()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.history)),
        ],
      ),
    );
  }

  Widget? _buildDrawer(currentPage) {
    if (currentPage == 0) {
      return const MainDrawer();
    } else {
      return null;
    }
  }
}
