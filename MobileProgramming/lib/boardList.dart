import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loa/loadrawer.dart';
import 'package:loa/boardTemplate.dart';

// 조찬희 템플릿 작성, 최준혁 DB 및 통신 연결
class BoardList extends StatefulWidget {
  final String subject;

  BoardList({required this.subject});

  @override
  _BoardListState createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  List<Map<String, dynamic>> course = [];


  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/get_board'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'subject': widget.subject,
        'boardtype': 'board',
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dataList = jsonData['data'] as List<dynamic>;

      print(jsonData['data']);
      print(dataList);
      setState(() {

        course = dataList.map((data) => {
          'id' : data['id'],
          'user' : data['user'],
          'title': data['title'],
          'content' : data['content'],
          'date': data['date'],
          'like' : data['like'],
          'dislike' : data['dislike'],
          'anonymous': data['anonymous']
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터를 초기에 불러옴
  }

  @override
  Widget build(BuildContext context) {
    if (course.isEmpty) {
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
              '과목 목록',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pop(context);

                },
              ),
            ],

          ),

          drawer: LoaDrawer(),
          body: Center(
            child: Text(
              '게시물이 없습니다!',
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
    } else {
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
            '과목 목록',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);

              },
            ),
          ],

        ),

        drawer: LoaDrawer(),
        body: showlist(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {

          },
          child: Icon(Icons.add),
        ),
      );}
  }

  Widget showlist() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: course.length,
      itemBuilder: (BuildContext context, int i) {
        String name = course[i]['title'];
        String boardid = '${course[i]['id']}';
        //String professor = course[i]['professor'];

        return Column(
          children: [
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => BoardTemplate(boardid: boardid,),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 80,
                      color: Color(0xFFD3D3D3).withOpacity(.84),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(50),
                      height: 50,
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset('assets/images/listTemplate.png'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(50),
                      height: 50,
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chevron_right,
                              size: 50, //Icon Size
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
