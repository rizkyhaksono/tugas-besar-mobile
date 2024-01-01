import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/database_appwrite.dart';
import 'package:push_puzzle/constants/resources.dart';

class ContactView extends GetView {
  ContactView({super.key});

  final DatabaseAppwrite databaseController = Get.put(DatabaseAppwrite());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact",
          style: TextStyle(
            color: Colors.white,
            fontFamily: Resources.font.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Resources.color.primaryBg,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: validateName,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: validateEmail,
              ),
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;

                  if (name.isNotEmpty && email.isNotEmpty) {
                    Map<String, dynamic> contactData = {
                      'name': name,
                      'email': email,
                      'message': messageController.text,
                    };
                    databaseController.storeContact(contactData);
                    Get.snackbar(
                      'Success',
                      'Send successful!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(16.0),
                      borderRadius: 8.0,
                      isDismissible: true,
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      shouldIconPulse: true,
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Name and email is required!',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 3),
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(16.0),
                      borderRadius: 8.0,
                      isDismissible: true,
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Resources.color.primaryBg,
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Resources.font.primaryFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
