import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';
import 'package:push_puzzle/presentation/controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(
            fontFamily: Resources.font.primaryFont,
            color: Colors.white,
          ),
        ),
        backgroundColor: Resources.color.primaryBg,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.news.length,
                itemBuilder: (context, index) {
                  final news = controller.news[index];
                  return ListTile(
                    title: Text(news.title),
                    onTap: () {
                      print('Selected news: ${news.title}');
                      controller.showDetailModal(news);
                    },
                  );
                },
              ),
      ),
    );
  }
}
