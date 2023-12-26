import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:push_puzzle/constants/resources.dart';
import 'dart:convert';

import 'package:push_puzzle/models/news_model.dart';
import 'package:push_puzzle/utils/format_date.dart';

class NewsController extends GetxController {
  final _news = <News>[].obs;
  final _isLoading = true.obs;
  final _hasError = false.obs;

  List<News> get news => _news;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      _isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://www.freetogame.com/api/games?platform=pc'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _news.assignAll(
            List<News>.from(data.map((json) => News.fromJson(json))));
        _hasError.value = false;

        print("Data: $data");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      _hasError.value = true;
    } finally {
      _isLoading.value = false;
    }
  }

  void showDetailModal(News news) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              news.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              news.shortDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Developer: ${news.developer}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Website : ${news.gameUrl}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Genre: ${news.genre}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Release: ${formatDate(news.releaseDate)}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                child: Image.network(
                  news.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Resources.color.primaryBg,
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
