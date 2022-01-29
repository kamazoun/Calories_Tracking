import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Text('Licences'),
          ),
        ],
      ),
    );
  }
}
