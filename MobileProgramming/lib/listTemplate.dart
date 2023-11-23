import 'package:flutter/material.dart';
import 'package:loa/main.dart';

class ListTemplate extends StatelessWidget {
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
          'List Templates',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: LoaDrawer(),
      //TODO
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            height: 50,
            child: const Center(
              child: Text('리스트를',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
            ),
          ),
          Container(
            height: 50,
            child: const Center(
              child: Text('만드시오',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          )),
        ],
      ),
    );
  }
}
