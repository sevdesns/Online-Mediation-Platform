import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

//56 yı halletceksin


class ChatListPage  extends StatefulWidget{
  final dynamic rool;
  const ChatListPage ({ super.key, required this.rool});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>{
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maillerim'),
        backgroundColor: Color.fromARGB(255, 32, 145, 186),
      ),
      body: _buildUserList(),
    );
  } 

  // build a list of users except for the current logged in user
  Widget _buildUserList(){

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasError){
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buidUserListItem(doc))
          .toList(),
        );
      },
    );
  }

  // build individual user list items
  Widget _buidUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    // display all users except current user
    if(_auth.currentUser!.uid != data['uid']){
      // int trueCheck = widget.rool.toString().compareTo(data['rool']);
      if(widget.rool.toString().compareTo(data['rool']) !=0){
      return ListTile(
        title: Text(data['name']),
        onTap: (){
          // pass the clicked user's UID to the chat page
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(
            receiveruserEmail: data['name'],
            receiverUserID: data['uid'],
          ),),);
        },
      );}
      else {
        return Container();
      }
    }
    else {
      //return empty container
      return Container();
    }
  }
}