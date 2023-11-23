// 과목 목록을 나타내는 리스트 템플릿을 만들어야함
import 'package:flutter/material.dart';
import 'package:loa/main.dart';

class BoardTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(onPressed: () {
              Scaffold.of(context).openDrawer();
            }, icon: Image.asset('assets/images/menulogo.png'));
          },
        ),
        title: Text(
          'Board Templates',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: LoaDrawer(),
      //TODO
      body: Container(
        width: 400,
        height: 800,
        decoration: ShapeDecoration(
            color: Colors.blue.shade100,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.5,color: Colors.grey),
                borderRadius: BorderRadius.circular(15)
            )
        ),
      child: Text("보드를 만드세요",
      style: TextStyle(fontSize: 40,
      fontWeight: FontWeight.bold),),
    )
    );
  }
}