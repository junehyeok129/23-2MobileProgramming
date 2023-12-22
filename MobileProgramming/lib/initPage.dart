import 'package:flutter/material.dart';
import 'package:loa/main.dart';
import 'package:loa/login.dart';
import 'package:loa/signup.dart';
import 'package:loa/loadrawer.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Image.asset('assets/images/menulogo.png'),
              );
            },
          ),
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  'Ranking',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        drawer: LoaDrawer(),
        body: TabBarView(
          children: [
            Container(
              child: Text("Profile 만들자",
              ),
            ),
            Container(
              child: Text("랭킹 만들자"),
            ),
          ],
        ),
      ),
    );
  }
}
