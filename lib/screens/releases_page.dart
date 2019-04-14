import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rocket/blocs/releases_bloc.dart';
import 'package:rocket/models/releases.dart';
import 'package:rocket/screens/releases_list_page.dart';

class ReleasesWidget extends StatefulWidget {
  @override
  ReleasesWidgetState createState() {
    return ReleasesWidgetState();
  }
}

class ReleasesWidgetState extends State<ReleasesWidget> {
  final ReleasesBloc _bloc = ReleasesBloc.getInstance();
  bool _isLoaded = false;

  final List<Tab> releasesTabs = <Tab>[
    Tab(
      text: 'Android',
    ),
    Tab(
      text: 'iOS',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _isLoaded = _bloc.isLoaded();
    if (!_isLoaded) {
      _bloc.load().then((value) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded ? _buildTabs() : _buildProgress();
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: releasesTabs.length,
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          TabBar(
            labelColor: Colors.white,
            tabs: releasesTabs,
          ),
          Expanded(
              child: TabBarView(
            children: releasesTabs.map((tab) {
              return _buildReleaseWidget(tab);
            }).toList(),
          ))
        ],
      ),
    );
  }

  Widget _buildReleaseWidget(Tab tab) {
    Platform platform =
        releasesTabs.first == tab ? Platform.Android : Platform.iOS;
    ReleaseModel m = platform == Platform.Android
        ? _bloc.findAndroidReleases().first
        : _bloc.findIOsReleases().first;
    return ReleaseWidget(
      model: m,
      features: _bloc.getFeatures(),
    );
  }

  Widget _buildProgress() {
    return Center(
      child: CircularProgressIndicator(
        value: null,
      ),
    );
  }
}

class ReleaseWidget extends StatelessWidget {
  final ReleaseModel model;
  final List<ReleaseFeatureModel> features;

  const ReleaseWidget({Key key, this.model, this.features}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  model.version,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              FlatButton(
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (context){
                    return ReleasesListWidget();
                  });
                },
                child: Row(
                  children: <Widget>[
                    Text(""),
                    Icon(Icons.navigate_next),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 92,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: _buildCheckPoints(),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return FeatureListItemWidget(
                feature: feature,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCheckPoints() {
    final bloc = ReleasesBloc.getInstance();
    List<ReleaseCheckPoint> list = bloc.buildCheckPointFor(model);
    return list.map((item) {
      return ReleaseCheckPointWidget(
        model: item,
        isFirst: item == list.first,
        isLast: item == list.last,
      );
    }).toList();
  }
}

class ReleaseCheckPointWidget extends StatelessWidget {
  static final _formatterFirst = new DateFormat('d MMMM', "ru_Ru");
  static final _formatterSecond = new DateFormat('EE', "ru_Ru");
  final ReleaseCheckPoint model;
  final bool isFirst;
  final bool isLast;

  ReleaseCheckPointWidget(
      {Key key, this.model, this.isFirst = false, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? 16 : 4, right: isLast ? 16 : 8),
      child: Container(
        width: 128,
        child: Card(
          elevation: model.isFall ? 4 : 8,
          margin: EdgeInsets.only(top: 8, bottom: 16, left: 0, right: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.name,
                  style: TextStyle(
                      color: model.isFall ? Colors.grey[600] : Colors.white),
                ),
                Container(
                  height: 4.0,
                ),
                Text(
                  _getCheckPointDate(model.dateTime),
                  style: TextStyle(
                      color:
                          model.isFall ? Colors.grey[600] : Colors.grey[400]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCheckPointDate(DateTime value) {
    if (value == null) {
      return "--/--";
    }
    return "${_formatterFirst.format(value)}, ${_formatterSecond.format(value).toUpperCase()}";
  }
}

class FeatureListItemWidget extends StatelessWidget {
  final ReleaseFeatureModel feature;

  const FeatureListItemWidget({Key key, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                feature.name,
                style: Theme.of(context).textTheme.subtitle,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4, top: 4),
                child: Text(
                  feature.desc,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                "",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
