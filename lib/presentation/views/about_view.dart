import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutView extends GetView {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Push Puzzle Crate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Description: A simple game that sharpens the logic of its players.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final webViewController = WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(const Color(0x00000000))
                      ..loadRequest(Uri.parse(
                          'https://github.com/rizkyhaksono/tugas-besar-mobile'));

                    Get.to(() => WebViewPage(webView: webViewController));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Resources.color.primaryBg,
                  ),
                  child: Text(
                    'Visit Website',
                    style: TextStyle(
                      fontFamily: Resources.font.primaryFont,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("test");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Resources.color.primaryBg,
                  ),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontFamily: Resources.font.primaryFont,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final WebViewController webView;

  const WebViewPage({Key? key, required this.webView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Website',
          style: TextStyle(
            color: Colors.white,
            fontFamily: Resources.font.primaryFont,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: webView,
      ),
    );
  }
}
