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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF8BBD0),
          onPrimary: Color(0xFF000000),
          secondary: Color(0xFFECEFF1),
          onSecondary: Color(0xFF000000),
          tertiary: Color(0xFFF5F5DC),
          onTertiary: Color(0xFF000000),
          error: Colors.red,
          onError: Colors.white,
          background: Color(0xFFFFFFFF),
          onBackground: Color(0xFF000000),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF000000),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFE91E63),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF263238),
          onSecondary: Color(0xFFFFFFFF),
          tertiary: Color(0xFF9C27B0),
          onTertiary: Color(0xFFFFFFFF),
          error: Colors.red,
          onError: Colors.white,
          background: Color(0xFF263238),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFF000000),
          onSurface: Color(0xFFFFFFFF),
        ),
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
      body: <Widget>[
        BabyCalendarScreen(
          screenBackground: Theme.of(context).colorScheme.primary,
        ),
        Container(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        Container(
          color: Theme.of(context).colorScheme.secondary,
        ),
        Container(
          color: Colors.green,
        ),
      ][selectedPageIndex],
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
