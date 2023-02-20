import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/screens/home_screen.dart';
import 'package:maps/screens/hotels_screen.dart';
import 'package:maps/screens/maps_screen.dart';
import 'package:maps/screens/restaurants_screen.dart';
import 'package:maps/widgets/hotels_app_bar.dart';
import 'package:maps/widgets/sites_app_bar.dart';

import 'screens/sites_screen.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/maps_app_bar.dart';
import 'widgets/restaurant_app_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        /*visualDensity: VisualDensity.adaptivePlatformDensity,*/
      ),
      home: MyHomePage(title: 'GoodTrips'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    FontAwesomeIcons.houseChimney,
    Icons.hotel,
    Icons.restaurant,
    Icons.travel_explore_sharp,
  ];
  int screenIndex=0;
  final screenList = <Widget> [
    HomeScreen(),
    HotelsScreen(),
    RestaurantsScreen(),
    SitesScreen(),
    OrderTrackingPage(),
  ];
  final appbarlist = <Widget> [
    HomeAppBar(),
    HotelAppBar(),
    RestaurantAppBar(),
    SitesAppBar(),
    MapAppBar(),
  ];
  final itemList = <String>[
    "Home",
    "Hotels",
    "Restaurants",
    "Sites",
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#115173'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: appbarlist[screenIndex],
          preferredSize: Size(100, 50),
      ),
      extendBodyBehindAppBar: true,
      extendBody:true,
      body: Expanded(child: screenList[screenIndex]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#ffd700'),
        child: Icon(
          Icons.map_rounded,
          color: HexColor('#115173'),
          size: 40,
        ),
        onPressed: () {
          setState(() {
            screenIndex = 4;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? HexColor('#FFd700') : HexColor('#ffffff');
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 30,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  "${itemList[index]}",
                  maxLines: 1,
                  style: TextStyle(color: color, fontSize: 18),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: HexColor('#115173'),
        activeIndex: screenIndex,
        splashColor: HexColor('#115173'),
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => screenIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,

      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
