import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter/material.dart';
// import 'contact.dart'; // Import contact model

class Contact {
  String name;
  String phone;

  Contact({required this.name, required this.phone});
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = []; // List of contacts

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addContact() {
    String name = _nameController.text;
    String phone = _phoneController.text;

    if (name.isNotEmpty && phone.isNotEmpty) {
      setState(() {
        contacts.add(Contact(name: name, phone: phone));
      });
      _nameController.clear();
      _phoneController.clear();
      Navigator.pop(context); // Close the dialog
    }
  }
void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: contacts.isEmpty
          ? Center(child: Text("No contacts added yet."))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(contacts[index].name),
                  subtitle: Text(contacts[index].phone),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteContact(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
 void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: _addContact, child: Text("Add")),
        ],
      ),
    );
  }
}
