import 'package:flutter/material.dart';

class NewsModel {
  final String title;
  final String content;
  final DateTime publishedAt;
  final List<String> tags;

  NewsModel(this.title, this.content, this.publishedAt, this.tags);

  static Color getColorForTag(String tag) {
    if (tag.endsWith("Sample")) {
      return Colors.blue;
    } else if (tag.contains("Android")) {
      return Colors.deepPurpleAccent;
    } else if (tag.contains("iOS")) {
      return Colors.teal;
    }
    return Colors.purple;
  }
}
