import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thai_journey_app/Provider/favourite_provider.dart';
import 'package:thai_journey_app/screens/home_screen.dart';
// import 'screens/testhome_screen.dart';
// import 'screens/search_screen.dart';
import 'screens/favourite_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavouriteProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'NotoSansThaiLooped',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndexPage = 0;

  List<Widget> widgetList = const [HomeScreen1(), FavouriteScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_selectedIndexPage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFF41C9E2),
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndexPage = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _selectedIndexPage,
        destinations: const <Widget>[
          NavigationDestination(
            key: Key('Home'),
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            key: Key('Fav'),
            selectedIcon: Icon(
              Icons.favorite_sharp,
              color: Colors.red,
            ),
            icon: Icon(Icons.favorite_sharp),
            label: 'Wishlist',
          ),
        ],
      ),

      //Version 1
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color(0xFF41C9E2),
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndexPage = index;
      //     });
      //   },
      //   currentIndex: _selectedIndexPage,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Color.fromARGB(255, 229, 41, 41),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Love',
      //     ),
      //   ],
      // ),
    );
  }
}
