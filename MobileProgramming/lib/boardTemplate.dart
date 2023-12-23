import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loa/loadrawer.dart';

class BoardTemplate extends StatefulWidget {
  final String boardid;
  BoardTemplate({required this.boardid});

  @override
  _BoardTemplateState createState() => _BoardTemplateState();
}

class _BoardTemplateState extends State<BoardTemplate> {
  bool isComplain = false;
  bool isHeart = false;
  bool isLike_0 = false;
  bool disLike_0 = false;
  bool isLike_1 = false;
  bool disLike_1 = false;

  final TextEditingController _commentController = TextEditingController();

  List<Map<String, dynamic>> course = [];

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/get_comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'boardid': widget.boardid,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dataList = jsonData['commentdata'] as List<dynamic>;

      setState(() {
        course = dataList.map((data) {
          return {
            'questionid': data['questionid'],
            'user': data['user'],
            'content': data['content'],
            'time': data['time'],
            'anonymous': data['anoymous'],
          };
        }).toList();
      });
    }
  }

  @override
  void initState() {
    fetchData(); // 데이터 가져오기
    super.initState();
  }

  List<Comment> comments = [];

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
        title: const Text(
          '게시판',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: LoaDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 400,
              decoration: ShapeDecoration(
                color: const Color.fromRGBO(246, 184, 184, 1.0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  // 데이터를 사용하여 질문과 작성 시간, 작성자 이름, 본문 내용 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        course.isNotEmpty ? course[0]['name'] : '',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, height: 1, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('2023.10.04 00:37'),
                      SizedBox(
                        width: 5,
                      ),
                      Text('익명'),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        SizedBox(
                          width: 330,
                          child: Text(
                            course.isNotEmpty ? course[0]['writer'] : '',
                            maxLines: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: onclickedComplain,
                        icon: Icon(
                          isComplain ? Icons.check : Icons.add_alert_outlined,
                        ),
                      ),
                      IconButton(
                        onPressed: onclickedHeart,
                        icon: Icon(
                          isHeart ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: Colors.red,
                      ),
                    ],
                  ),

                  // course 리스트를 사용하여 게시판 항목 생성
                  for (var courseItem in course)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseItem['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(courseItem['writer']),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: onclickedLike_0,
                                        icon: Icon(
                                          isLike_0
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_outlined,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: onclickedDisLike_0,
                                        icon: Icon(
                                          disLike_0
                                              ? Icons.thumb_down
                                              : Icons.thumb_down_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              labelText: 'Your Comment',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            String commentContent = _commentController.text;
                            String commenterName = '익명';
                            Comment newComment =
                            Comment(name: commenterName, content: commentContent);
                            setState(() {
                              comments.add(newComment);
                              _commentController.clear();
                            });
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onclickedComplain() {
    setState(() {
      isComplain = !isComplain;
    });
  }

  void onclickedHeart() {
    setState(() {
      isHeart = !isHeart;
    });
  }

  void onclickedLike_0() {
    setState(() {
      isLike_0 = !isLike_0;
    });
  }

  void onclickedDisLike_0() {
    setState(() {
      disLike_0 = !disLike_0;
    });
  }
}

class Comment {
  final String name;
  final String content;

  Comment({required this.name, required this.content});
}
