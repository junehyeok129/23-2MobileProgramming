import 'package:flutter/material.dart';
import 'package:loa/main.dart';
import 'package:loa/loadrawer.dart';

class AutoAdjustTextSize extends StatefulWidget {
  @override
  _AutoAdjustTextSizeState createState() => _AutoAdjustTextSizeState();
}

class _AutoAdjustTextSizeState extends State<AutoAdjustTextSize> {
  String textContent = 'dart를 공부하려는데 하나도 모르겠어요. 어쩌죠? 진짜 급해요';

  double calculateFontSize(String text) {
    // 글자 길이에 따라 동적으로 글자 크기를 조절
    if (text.length > 15) {
      return 10.0;
    } else {
      return 20.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: TextStyle(fontSize: calculateFontSize(textContent)),
    );
  }
}

class BoardTemplate extends StatefulWidget {
  const BoardTemplate({Key? key}) : super(key: key);

  @override
  State<BoardTemplate> createState() => _BoardTemplateState();
}

class _BoardTemplateState extends State<BoardTemplate> {
  bool isComplain = false;
  bool isHeart = false;
  bool isLike_0 = false;
  bool disLike_0 = false;
  bool isLike_1 = false;
  bool disLike_1 = false;

  final TextEditingController _commentController = TextEditingController();
  final String question= 'dart를 공부하려는데 하나도 모르겠어요. 어쩌죠? 진짜 급해요';
  final List<Map<String, dynamic>> comments = [
    {
      'name':'익명',
      'comment': 'Flutter 홈페이지에 Dart 튜토리얼 있습니다.'
    },
    {
      'name':'익명',
      'comment': '유투브에 좋은 자료가 많으니 확인해보세요'
    }
  ];

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

  void onclickedLike_1() {
    setState(() {
      isLike_1 = !isLike_1;
    });
  }

  void onclickedDisLike_1() {
    setState(() {
      disLike_1 = !disLike_1;
    });
  }
  void changetext(text){
    setState(() {

    });
  }
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
          'Board Templates',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: LoaDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Q. Dart가 너무 어려워요",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1, height: 1, color: Colors.black),

                    // 날짜 추가
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: Row(
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
                        ))
                      ],
                    ),

                    // 본문 내용 추가

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          AutoAdjustTextSize()
                        ],
                      ),
                    ),

                    // 본문 하트와 신고 아이콘 추가
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
                            isHeart
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: Colors.red,
                        ),
                      ],
                    ),

                    // 댓글 추가
                    Divider(thickness: 1, height: 1, color: Colors.black12),

                    // 댓글 1
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Text(
                            '익명',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15),
                              Text('Flutter홈페이지에 Dart튜토리얼 있습니다.'),
                            ],
                          ),
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
                    ),

                    // 댓글 2
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Text(
                            '익명',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15),
                              Text('유튜브에 좋은 자료가 많으니 확인해보세요.'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: onclickedLike_1,
                                icon: Icon(
                                  isLike_1
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_outlined,
                                ),
                              ),
                              IconButton(
                                onPressed: onclickedDisLike_1,
                                icon: Icon(
                                  disLike_1
                                      ? Icons.thumb_down
                                      : Icons.thumb_down_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 댓글 작성 폼 추가
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
                              // 댓글 전송 로직 추가
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
      ),
    );
  }
}