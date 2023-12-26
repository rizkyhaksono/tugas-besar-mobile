import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  final List<String> splashData = [
    'Welcome to Puzzle App\nEmbark on a journey of mind-bending challenges and immersive fun. Unleash your inner puzzle solver!',
    'Discover Amazing Features\nExplore a world of captivating puzzles and unlock hidden treasures. Our app is packed with unique and exciting challenges.',
    'Enjoy Using the App\nImmerse yourself in a seamless and delightful puzzle-solving experience. From novices to experts, everyone can savor the joy of accomplishment.',
  ];

  final List<String> imagesAssets = [
    "assets/images/splash1.png",
    "assets/images/splash2.png",
    "assets/images/splash3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resources.color.primaryBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index],
                    imagePath: imagesAssets[index],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildDot(0),
                      buildDot(1),
                      buildDot(2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed("/signin");
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Resources.color.crateBox,
                    fontFamily: Resources.font.primaryFont,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            controller.currentPage.value == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String text;
  final String imagePath;

  const SplashContent({super.key, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    print('Image Path: $imagePath');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Puzzle Push Crate',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: Resources.font.primaryFont,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontFamily: Resources.font.primaryFont,
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
