import 'package:flutter/material.dart';
import 'package:rocket/models/news.dart';

class TagsWidget extends StatelessWidget {
  final List<String> tags;

  const TagsWidget({Key key, this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: tags.map((tag) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: NewsModel.getColorForTag(tag),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(tag),
          ),
        ),
      );
    }).toList());
  }
}
