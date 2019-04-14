import 'package:flutter/material.dart';
import 'package:rocket/themes.dart';
import 'package:rocket/widgets/common_widgets.dart';
import 'package:rocket/models/news.dart';

/// News details page.
class NewsDetailsWidget extends StatelessWidget {
  final NewsModel model;

  const NewsDetailsWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: _buildCloseButton(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TagsWidget(
                    tags: model.tags,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    model.title,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Text(
                    model.content,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildThumbButton(Icons.thumb_up, () {
                        Navigator.pop(context);
                      }),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      _buildThumbButton(Icons.thumb_down, () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return RawMaterialButton(
      fillColor: AppColors.backgroundColor,
      onPressed: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.close,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Закрыть".toUpperCase(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      shape: StadiumBorder(
        side: BorderSide(color: Colors.white, width: 1),
      ),
    );
  }

  Widget _buildThumbButton(IconData icon, VoidCallback callback) {
    return Container(
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(color: Colors.white),
        ),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: callback,
      ),
    );
  }
}
