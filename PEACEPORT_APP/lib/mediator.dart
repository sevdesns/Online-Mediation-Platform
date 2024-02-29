import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peace/chat_pages/chat_list_page.dart';
import 'package:peace/components/component/drawer.dart';
import 'package:peace/pages/profile_page.dart';
import 'login.dart';

class Mediator extends StatefulWidget {
  const Mediator({super.key});

  @override
  State<Mediator> createState() => _MediatorState();
}

class _MediatorState extends State<Mediator> {
  String? userEmail;

  @override
  void initState() {   
    super.initState();
    getEmail();
  }
  
  Future<void> getEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
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
    CircularProgressIndicator(); 
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatListPage(rool: Mediator,),
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

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut(); //google signOut //bunlar çalışmazsa tekrardan birleştirip alttaki kodu kullanıcaz
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

/* Future<void> _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
*/
