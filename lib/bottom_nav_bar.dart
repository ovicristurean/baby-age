import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int> onPageSelected;

  const AppBottomNavigationBar({Key? key, required this.onPageSelected})
      : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      indicatorColor: Theme.of(context).colorScheme.primary,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          widget.onPageSelected(index);
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
        NavigationDestination(
          icon: Icon(Icons.pregnant_woman),
          label: 'You',
        ),
        NavigationDestination(
          icon: Icon(Icons.baby_changing_station),
          label: 'Your baby',
        ),
        NavigationDestination(
          icon: Icon(Icons.man),
          label: 'Dad',
        )
      ],
    );
  }
}
