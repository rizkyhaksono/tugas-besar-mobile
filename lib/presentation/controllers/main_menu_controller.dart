import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class MainMenuController extends GetxController {
  RxMap<String, dynamic> leaderboard = <String, dynamic>{}.obs;
  late int remainingTimeInSeconds = 300;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
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
    leaderboard.value = await fetchLeaderboard();

    leaderboard.forEach((username, score) {
      print('$username: $score');
    });
  }

  int calculateScore(int timeTakenInSeconds) {
    const int maxScore = 100;
    const int maxTimeInSeconds = 300;

    int adjustedTime = timeTakenInSeconds > maxTimeInSeconds
        ? maxTimeInSeconds
        : timeTakenInSeconds;

    double percentage = adjustedTime / maxTimeInSeconds;
    int calculatedScore = (percentage * maxScore).round();

    return calculatedScore;
  }

  Future<void> inputLeaderboard(score) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await updateLeaderboard(
          currentUser.displayName ?? currentUser.uid, score);

      leaderboard.value = await fetchLeaderboard();

      print('Data pushed to leaderboard successfully.');
    } else {
      print('User not authenticated.');
    }
  }
}
