import 'package:flutter/material.dart';
import 'package:jellyfish/pages/category.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:jellyfish/pages/profile.dart';
import 'MyColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: blueLatte,
          brightness: Brightness.light,
          primary: blueLatte,
          onPrimary: textLatte,
          secondary: blueLatte,
          onSecondary: textLatte,
          error: redLatte,
          onError: textLatte,
          background: baseLatte,
          onBackground: textLatte,
          surface: overlay0Latte,
          onSurface: textLatte
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> pages = const [
    CategoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseLatte,
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: baseLatte,
        surfaceTintColor: textLatte,
        indicatorColor: overlay0Latte,
        shadowColor: overlay0Latte,
        animationDuration: const Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(TablerIcons.layout_grid),
            icon: Icon(TablerIcons.layout_grid),
            label: 'Category',
          ),

          NavigationDestination(
            selectedIcon: Icon(TablerIcons.user),
            icon: Icon(TablerIcons.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
