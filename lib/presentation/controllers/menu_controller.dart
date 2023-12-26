import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  final player = AudioCache();

  @override
  void onInit() {
    super.onInit();
    playMusic();
  }

  Future<void> playMusic() async {
    try {
      await player.play("music/bg.mp3");
    } catch (e) {
      print("Error playing music: $e");
    }
  }
}
