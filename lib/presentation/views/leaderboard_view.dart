import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/main_menu_controller.dart';

class LeaderboardView extends GetView<MainMenuController> {
  const LeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.showLeaderboard();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Resources.color.primaryBg,
        title: Text(
          'Leaderboard',
          style: TextStyle(
            color: Colors.white,
            fontFamily: Resources.font.primaryFont,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(
        () {
          if (controller.leaderboard.isEmpty) {
            return Center(
                child: CircularProgressIndicator(
              color: Resources.color.primaryBg,
            ));
          } else {
            return ListView.builder(
              itemCount: controller.leaderboard.length,
              itemBuilder: (context, index) {
                String username = controller.leaderboard.keys.elementAt(index);
                dynamic score = controller.leaderboard[username]!;

                return ListTile(
                  title: Text('$username'),
                  subtitle: Text('Score: $score'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
