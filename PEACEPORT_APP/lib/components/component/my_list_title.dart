import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const MyListTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 87, 2, 2),
          size: 24, // Küçük piksel boyutu burada ayarlanır
        ),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16), // Küçük piksel boyutu burada ayarlanır
        ),
      ),
    );
  }
}