import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:rocket/data/news_api.dart';
import 'package:rocket/models/news.dart';
import 'package:rocket/screens/news_detail_page.dart';
import 'package:rocket/widgets/common_widgets.dart';
import 'package:rocket/widgets/running_text_widget.dart';

class NewsWidget extends StatefulWidget {
  @override
  NewsWidgetState createState() {
    return new NewsWidgetState();
  }
}

class NewsWidgetState extends State<NewsWidget> {
  List<NewsModel> _list;
  NewsApi _api = NewsApi();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _api.getNews().then((list) {
      setState(() {
        _isLoading = false;
        _list = list;
      });
    });
  }

  List<Widget> _buildNewsList(List<NewsModel> list) {
    Map<DateTime, List<NewsModel>> map = groupBy(list, (NewsModel item) {
      return item.publishedAt;
    });
    List<Widget> result = [];
    map.forEach((d, items) {
      result.add(TitleWidget(
        date: d,
      ));
      items.forEach((model) {
        result.add(
          NewsShortItem(model: model),
        );
      });
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              children: <Widget>[
                ShaderMask(
                  child: Container(
                    height: 28,
                    child: RunningTextWidget(),
                  ),
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment(-1.1, 0),
                      end: Alignment(0.92, 0),
                      stops: [0, 0.05, 0.94, 1],
                      colors: <Color>[
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                        Colors.transparent,
                      ],
                    ).createShader(bounds);
                  },
                ),
                Container(
                  height: 1,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              key: PageStorageKey<String>("NewsKey"),
              children: _buildNewsList(_list),
            ),
          ),
        ],
      );
    }
  }
}

class NewsShortItem extends StatelessWidget {
  final NewsModel model;

  const NewsShortItem({this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NewsDetailsWidget(model: model);
        }));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TagsWidget(
              tags: model.tags,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Text(
                model.title,
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            Text(
              model.content,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
              ),
              overflow: TextOverflow.fade,
              softWrap: false,
            )
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  static final _formatterFirst = new DateFormat('d MMMM, EEEE', "ru_Ru");

  final DateTime date;

  const TitleWidget({Key key, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _formatterFirst.format(date).toUpperCase(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
