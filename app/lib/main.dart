import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:jellyfish/pages/bluetooth/backgroundtask.dart';
import 'package:jellyfish/pages/main/category.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:jellyfish/pages/main/profile.dart';
import 'package:jellyfish/pages/setting.dart';
import 'common/db_provider.dart';
import 'MyColor.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<User>? users = await DBProvider.getUsers();

  runApp(MyApp(home : users == null ? const Setting(isEdit: false,) : MyHomePage(user: users[0],)));
}

class MyApp extends StatelessWidget {
  final Widget? home;
   const MyApp({
    super.key,
     this.home
  });

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
      home: home,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final User user;
  const MyHomePage({super.key, required this.user});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  BackgroundTask? backgroundTask;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const CategoryPage(),
      ProfilePage(user: widget.user,),
    ];

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
  Future<void> _startBackgroundTask(BluetoothDevice device) async {
    try {
      backgroundTask = await BackgroundTask.connect(device);
    } catch (e) {
      print(e);
    }
  }
}
