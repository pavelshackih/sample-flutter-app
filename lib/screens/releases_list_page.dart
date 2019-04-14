import 'package:flutter/material.dart';
import 'package:rocket/themes.dart';

class ReleasesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.transparent,
      child: new Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.95,
              ],
              colors: [
                AppColors.bottomDialogStartColor,
                AppColors.bottomDialogEndColor,
              ]),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Container(
                height: 98,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildReleaseWidget(
                      context: context,
                      release: "",
                      date: "12 April",
                      isSelected: true,
                      isFirst: true,
                    ),
                    _buildReleaseWidget(
                        context: context,
                        release: "",
                        date: "12 April"),
                    _buildReleaseWidget(
                        context: context,
                        release: "",
                        date: "12 April"),
                    _buildReleaseWidget(
                        context: context,
                        isLast: true,
                        release: "",
                        date: "12 April"),
                  ],
                ),
              ),
            ),
            Container(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReleaseWidget(
      {@required BuildContext context,
      @required String release,
      @required String date,
      bool isSelected = false,
      bool isFirst = false,
      bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? 8 : 0, right: isLast ? 8 : 0),
      child: Container(
        width: 164,
        height: 96,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    release,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.android,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 4,
                      ),
                      Text(
                        date.toUpperCase(),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
