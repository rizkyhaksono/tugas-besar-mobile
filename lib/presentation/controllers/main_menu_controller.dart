import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:push_puzzle/constants/resources.dart';

class MainMenuController extends GetxController {
  late AudioPlayer audioPlayer;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  final DatabaseReference _leaderboardRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://uap-project-94203-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  Future<void> updateLeaderboard(String username, int score) async {
    await _leaderboardRef.child(username).set(score);
  }

  Future<Map<String, dynamic>> fetchLeaderboard() async {
    DatabaseEvent snapshot = await _leaderboardRef.once();
    Map<dynamic, dynamic> data =
        snapshot.snapshot.value as Map<dynamic, dynamic>;
    Map<String, dynamic> leaderboard = Map<String, dynamic>.from(data);

    return leaderboard;
  }

  void showLeaderboard() async {
    Map<String, dynamic> leaderboard = await fetchLeaderboard();

    print('Leaderboard:');
    leaderboard.forEach((username, score) {
      print('$username: $score');
    });

    String leaderboardText = 'Leaderboard:\n';
    leaderboard.forEach((username, score) {
      leaderboardText += '$username: $score\n';
    });
    Get.snackbar(
      'Leaderboard',
      leaderboardText,
      backgroundColor: Colors.white,
      colorText: Resources.color.primaryBg,
    );
  }
}
