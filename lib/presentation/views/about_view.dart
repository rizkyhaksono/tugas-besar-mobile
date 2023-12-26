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
            ElevatedButton(
              onPressed: () {
                final webViewController = WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setBackgroundColor(const Color(0x00000000))
                  ..loadRequest(Uri.parse(
                      'https://github.com/rizkyhaksono/tugas-besar-mobile'));

                Get.to(() => WebViewPage(webView: webViewController));
              },
              child: const Text('Visit Website'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print("test");
              },
              child: const Text('Contact Us'),
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
