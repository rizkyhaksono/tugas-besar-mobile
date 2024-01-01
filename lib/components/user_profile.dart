import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:push_puzzle/constants/auth_service.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends GetView {
  final AuthService _authService = AuthService();
  File? pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  final RxString imagePath = "".obs;

  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GestureDetector(
          onTap: () async {
            User? currentUser = await _authService.getCurrentUser();

            Get.bottomSheet(
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: _buildHeader(currentUser),
                          ),
                          Flexible(
                            child: _buildListItem(
                              Icons.person,
                              getUserDisplayName(currentUser),
                            ),
                          ),
                          Flexible(
                            child: _buildListItem(
                              Icons.exit_to_app,
                              'Logout',
                              textColor: Colors.red,
                              onTap: () async {
                                bool? confirmSignOut =
                                    await showSignOutConfirmationDialog(
                                        context);

                                if (confirmSignOut != null && confirmSignOut) {
                                  await _authService.signOut();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: _buildCircleAvatar(),
        );
      },
    );
  }

  Widget _buildHeader(User? currentUser) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            // Handle click on CircleAvatar
            await _changeProfileImage();
            // setState(() {}); // Trigger a rebuild after changing the image
          },
          child: CircleAvatar(
            // backgroundImage: _getProfileImage(currentUser),
            radius: 40,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Hello, ${getUserDisplayName(currentUser)}!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: Resources.font.primaryFont,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _buildListItem(
    IconData icon,
    String text, {
    Color? textColor,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
          fontFamily: Resources.font.primaryFont,
        ),
      ),
      onTap: onTap,
    );
  }

  String getUserDisplayName(User? user) {
    if (user != null) {
      if (user.providerData.isNotEmpty) {
        if (user.providerData[0].providerId == 'google.com') {
          return user.displayName ?? 'N/A';
        } else {
          return user.email?.split('@')[0] ?? 'N/A';
        }
      }
    }
    return 'N/A';
  }

  Future<bool?> showSignOutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage == null) {
      return;
    } else {
      final Directory appDirectory = await getApplicationCacheDirectory();
      final String fileName = 'profile_image.png';
      final String newPath = '${appDirectory.path}/$fileName';

      // Save the new image path in SharedPreferences
      prefs.setString('profile_image', newPath);

      // Update the reactive state to trigger a rebuild
      imagePath.value = newPath;

      Get.back();
      Get.snackbar(
        "Image Pick Successfully",
        "You successfully changed the image",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildCircleAvatar() {
    return CircleAvatar(
      backgroundImage: const AssetImage("assets/images/profile-default.png"),
    );
  }

  Future<void> takePhoto(ImagePicker picker, String? currentImagePath) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage == null) {
      return;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Directory appDirectory = await getApplicationCacheDirectory();
      final String fileName = 'profile_image.png';
      final String newPath = '${appDirectory.path}/$fileName';

      prefs.setString('profile_image', newPath);

      Get.snackbar(
        "Image Pick Successfully",
        "You successfully changed the image",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
