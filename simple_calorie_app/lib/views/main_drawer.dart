import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_calorie_app/views/admin/admin_auth_screen.dart';
import 'package:simple_calorie_app/views/admin/food_list.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const CircleAvatar(
              radius: 100,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: const Text('Licences'),
            onTap: () => Get.off(() => const AdminAuthScreen()),
          ),
        ],
      ),
    );
  }
}
