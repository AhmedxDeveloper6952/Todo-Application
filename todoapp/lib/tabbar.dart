import 'package:flutter/material.dart';
import 'package:todoapp/favouritepage.dart';
import 'package:todoapp/taskpage.dart';

class Tabbar extends StatefulWidget {
  Tabbar({super.key});

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Tasks',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            tabs: [
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favorites',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Tasks',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Favouritepage(),
            TaskPage(),
          ],
        ),
      ),
    );
  }
}
