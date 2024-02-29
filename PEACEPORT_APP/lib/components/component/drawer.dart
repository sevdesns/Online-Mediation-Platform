import 'package:flutter/material.dart';
import 'package:peace/components/component/my_list_title.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 32, 145, 186),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Set the background color to blue
            ),
            child: Icon(
              Icons.person,
              color: Colors.white, // Set the icon color to white
              size: 70,
            ),
          ),
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),
          MyListTile(
            icon: Icons.person,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),
          MyListTile(
            icon: Icons.logout,
            text: "L O G O U T",
            onTap: onSignOut,
          ),
        ],
      ),
    );
  }
}