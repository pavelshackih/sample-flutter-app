import 'package:flutter/material.dart';
import 'package:rocket/screens/news_page.dart';
import 'package:rocket/screens/releases_page.dart';
import 'package:rocket/themes.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.bottomPanelBackgroundColor,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentScreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              title: Text(""),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentScreen = index;
            });
          },
        ),
      ),
      body: SafeArea(
        child: _currentScreen == 0 ? NewsWidget() : ReleasesWidget(),
      ),
    );
  }
}
