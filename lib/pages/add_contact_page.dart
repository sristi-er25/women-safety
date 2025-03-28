import 'package:flutter/material.dart';
import 'package:women_safety/pages/contactspage.dart';
import 'package:women_safety/pages/homepage.dart';


class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Column(
          children: [
            Text('Add Emergency Contacts', style: TextStyle(fontSize: 28),),
          
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactsPage(),));
          }, child: Text('next')),
            
          ],
        ),
      ),
    );
  }
}