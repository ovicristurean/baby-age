import 'package:baby_age/bottom_nav_bar.dart';
import 'package:baby_age/presentation/screens/baby_calendar_screen.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: <Widget>[
          const BabyCalendarScreen(),
          Container(
            color: Colors.teal,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
        ][selectedPageIndex],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        onPageSelected: (selectedPageIndex) {
          setState(() {
            this.selectedPageIndex = selectedPageIndex;
          });
        },
      ),
    );
  }
}
