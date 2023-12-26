import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

class ClientAppwrite extends GetxController {
  Client client = Client();

  @override
  void onInit() {
    super.onInit();
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('658252010f643e3dfdb0')
        .setSelfSigned(status: true);
  }
}
