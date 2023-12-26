import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/database_appwrite.dart';

class ContactView extends GetView {
  ContactView({super.key});

  final DatabaseAppwrite databaseController = Get.put(DatabaseAppwrite());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact")),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(labelText: 'Message'),
            maxLines: 3, // Adjust as needed
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Create a map with the entered data
              Map<String, dynamic> contactData = {
                'name': nameController.text,
                'email': emailController.text,
                'message': messageController.text,
              };

              // Call the method to store the contact in the database
              databaseController.storeContact(contactData);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
