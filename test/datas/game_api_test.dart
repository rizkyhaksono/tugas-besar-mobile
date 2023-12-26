import 'package:flutter_test/flutter_test.dart';
import 'package:push_puzzle/models/news_model.dart';

void main() {
  test('News model JSON serialization and deserialization', () {
    final news = News(
      id: 540,
      title: 'Overwatch 2',
      thumbnail: 'https://www.freetogame.com/g/540/thumbnail.jpg',
      shortDescription:
          'A hero-focused first-person team shooter from Blizzard Entertainment.',
      gameUrl: 'https://www.freetogame.com/open/overwatch-2',
      genre: Genre.SHOOTER,
      platform: Platform.PC_WINDOWS,
      publisher: 'Activision Blizzard',
      developer: 'Blizzard Entertainment',
      releaseDate: DateTime(2022, 10, 4),
      freetogameProfileUrl: 'https://www.freetogame.com/overwatch-2',
    );

    final jsonNews = news.toJson();

    final decodedNews = News.fromJson(jsonNews);

    expect(decodedNews.id, news.id);
    expect(decodedNews.title, news.title);
    expect(decodedNews.thumbnail, news.thumbnail);
    expect(decodedNews.shortDescription, news.shortDescription);
    expect(decodedNews.gameUrl, news.gameUrl);
    expect(decodedNews.genre, news.genre);
    expect(decodedNews.platform, news.platform);
    expect(decodedNews.publisher, news.publisher);
    expect(decodedNews.developer, news.developer);
    expect(decodedNews.releaseDate, news.releaseDate);
    expect(decodedNews.freetogameProfileUrl, news.freetogameProfileUrl);
  });
}
