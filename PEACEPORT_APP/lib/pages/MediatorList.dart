import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediatorList extends StatefulWidget {
  MediatorList({Key? key});

  final _userStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  State<MediatorList> createState() => _MediatorListState();
}

class _MediatorListState extends State<MediatorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mediator List"),
        backgroundColor: Color.fromARGB(255, 32, 145, 186),
      ),
      body: StreamBuilder(
        stream: widget._userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Connection Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var users = docs[index];
              String role = users['rool']; // Use '??' for fallback

              // Check if the user role is 'Mediator'
              if (role == 'Mediator') {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(users['name']),
                  subtitle: Text('${users['bio']}'),
                );
              } else {
                // If the role is not 'Mediator', return an empty container
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}