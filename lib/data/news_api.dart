import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rocket/data/server_api.dart';
import 'package:rocket/models/news.dart';

abstract class NewsApi {
  static NewsApi _instance = NetworkNewsApi();

  Future<List<NewsModel>> getNews();

  factory NewsApi() => _instance;
}

class NetworkNewsApi implements NewsApi {
  @override
  Future<List<NewsModel>> getNews() {
    final response = http.get("${NetworkConst.baseUrl}/news").then((response) {
      return NetworkConst.codec.decode(response.bodyBytes);
    }).then((value) {
      final result = List<NewsModel>();
      final List<dynamic> list = json.decode(value);
      for (final item in list) {
        final List<dynamic> parsedTags = item["tags"];
        final List<String> tags = List<String>();
        for (final tag in parsedTags) {
          tags.add(tag as String);
        }
        final model = NewsModel(item["title"], item["content"],
            DateTime.parse(item["published_at"]), tags);
        result.add(model);
      }
      return result;
    });
    return response;
  }
}
