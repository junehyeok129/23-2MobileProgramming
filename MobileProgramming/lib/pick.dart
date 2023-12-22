import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loa/loadrawer.dart';

class Pick extends StatefulWidget {

  @override
  _PickState createState() => _PickState();
}

class _PickState extends State<Pick> {
  List<Map<String, dynamic>> course = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Pick',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      drawer: LoaDrawer(),
      body: Center(
        child: Text(
          'Loa 버전 2를 기대하세요!',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
