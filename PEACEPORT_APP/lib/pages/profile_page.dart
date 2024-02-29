import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peace/components/component/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Firestore collection reference
  final userCollection = FirebaseFirestore.instance.collection('users');

  String name = '';
  String bio = '';

  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde veriyi otomatik olarak al
    getFirestoreData();
  }

  Future<void> getFirestoreData() async {
  try {
    DocumentSnapshot snapshot = await userCollection.doc(currentUser.uid).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          name = data['name']?.toString() ?? "isim bulunamadı";
          bio = data['bio']?.toString() ?? "bio bulunamadı";
        });
      }
    } else {
      setState(() {
        name = "isim bulunamadı";
        bio = "Bio bulunamadı";
      });
    }
  } catch (e) {
    setState(() {
      name = "Hata: $e";
      bio = "Hata: $e";
    });
  }
}

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),

          // save button
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      // only update if there is something in the textfield
      try {
        await userCollection.doc(currentUser.email!).update({field: newValue});
      } catch (e) {
        print("Error updating Firestore: $e");
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
    print("Building ProfilePage"); // Debug print
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 214, 219),
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor:  Color.fromARGB(255, 32, 145, 186),
      ),
      body: ListView(
        
              children: [
                const SizedBox(height: 50),
                // profile pic
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 10),
                // user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 50),
                // user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                // username
                MyTextBox(
                  text: name,
                  sectionName: "name",
                  onPressed: () => editField('name'),
                ),
                // bio
                MyTextBox(
                  text: bio,
                  sectionName: "bio",
                  onPressed: () => editField('bio'),
                ),
              ],
            ),

      
    );
  }
}