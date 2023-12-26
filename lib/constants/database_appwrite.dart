import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/client_appwrite.dart';

class DatabaseAppwrite extends ClientAppwrite {
  Databases? databases;

  RxList<Document> documents = <Document>[].obs;

  @override
  void onInit() {
    super.onInit();
    databases = Databases(client);
  }

  Future<void> storeContact(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "658ad886896f9a29981d",
        documentId: ID.unique(),
        collectionId: "658ad88bdfd5b0356272",
        data: map,
        permissions: [
          // Permission.read(Role.user("658ad9a992f068430f2a")),
          // Permission.update(Role.user("658ad9a992f068430f2a")),
          // Permission.delete(Role.user("658ad9a992f068430f2a")),

          // config role any
          Permission.read(Role.any()),
          Permission.update(Role.any()),
          Permission.delete(Role.any()),
        ],
      );
      print("DatabaseController:: storeUserName $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
