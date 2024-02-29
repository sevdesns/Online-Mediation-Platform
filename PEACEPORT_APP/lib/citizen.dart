import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:peace/components/component/drawer.dart';

import 'package:peace/chat_pages/chat_list_page.dart';
import 'login.dart';
import 'pages/MediatorList.dart';
import 'pages/profile_page.dart';

class Citizen extends StatefulWidget {
  const Citizen({Key? key}) : super(key: key); // bunu anlmadım ne işe yarıyor ???

  @override
  State<Citizen> createState() => _CitizenState();
}

class _CitizenState extends State<Citizen> {
    String? userEmail;

  @override
  void initState() {   
    super.initState();
    // initState içinde kullanıcının email adresini almak için bir fonksiyon çağırın
    getEmail();
  }

  Future<void> getEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Firebase Authentication ile giriş yapan kullanıcının email adresini alın
      setState(() {
        userEmail = user.email;
      });
    }
  }
  // Navigate to profile page
  void goToProfilePage() {
    // Pop menu drawer
    Navigator.pop(context);

    // Go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  // Sign out method
  Future<void> signOut() async {
    CircularProgressIndicator(); // ne işe yarıyor ??? 
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut(); //google signOut
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 214, 219),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 145, 186),
        title: Text("My Page"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          // Sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Add your widgets here
              Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fdepositphotos.com%2Ftr%2Fphotos%2Fprofil-resmi.html&psig=AOvVaw2PzQHDWyJq6H9u_UWy5JT6&ust=1704559917817000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJDQu7Ckx4MDFQAAAAAdAAAAABAe',
              ),
            ),
            SizedBox(height: 10),
            Text(
              //kullanıcının maili göster boşsa boş bir str dönder
              userEmail ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //dava oluştur butonuna basınca yapılacak işlemler
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediatorList(),
                      ),
                    );
                  },
                  child: Text('Mediator List'),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () { // Maillerim butonuna basıldığında yapılacak işlemler
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatListPage(rool: Citizen,),
                      ),
                    );
                  },
                  child: Text('Messages'),
                ),
              ],
            ),
          ],
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }
}