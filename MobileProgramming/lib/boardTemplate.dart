// 과목 목록을 나타내는 리스트 템플릿을 만들어야함
import 'package:flutter/material.dart';
import 'package:loa/main.dart';

class BoardTemplate extends StatefulWidget {
  const BoardTemplate({super.key});

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

  // 신고 부분에 대한 onpressed 대응 함수 처리
  void onclickedComplain() {
    setState(() {
      isComplain = !isComplain;
    });
  }

  // 하트 부분에 대한 onpressed 대응 함수 처리
  void onclickedHeart() {
    setState(() {
      isHeart = !isHeart;
    });
  }

  //댓글 익명 0번에 대한 좋아요, 싫어요 대응 함수 처리
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

  //댓글 익명 1번에 대한 좋아요, 싫어요 대응 함수 처리
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
                  icon: Image.asset('assets/images/menulogo.png'));
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
        //TODO
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 650,
              decoration: ShapeDecoration(
                  color: const Color.fromRGBO(246, 184, 184, 1.0),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15))),
              child: Column(
                //내용 전체를 Column으로 감싸서 작성하였음.
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    //제목 시작
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Q. Dart가 너무 어려워요",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, height: 1, color: Colors.black),
                  const SizedBox(
                    height: 8,
                  ),
                  // 여기 까지 제목

                  //날짜
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('2023.10.04 00:37'),
                      SizedBox(
                        width: 5,
                      ),
                      Text('익명'),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  //본문 시작
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      SizedBox(width: 15),
                      Text('dart를 공부하려는데 하나도 모르겠어요. 어쩌죠? 진짜 급해요 '),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: onclickedComplain,
                          icon: Icon(isComplain
                              ? Icons.check
                              : Icons.add_alert_outlined)),
                      IconButton(
                        onPressed: onclickedHeart,
                        icon: Icon(
                          isHeart ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: Colors.red,
                      )
                    ],
                  ),

                  //본문 끝

                  //댓글 시작
                  const Divider(thickness: 1, height: 1, color: Colors.black12),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Text('익명', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 15),
                          Text('Flutter홈페이지에 Dart튜토리얼 있습니다.'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: onclickedLike_0,
                            icon: Icon(isLike_0
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined),
                          ),
                          IconButton(
                              onPressed: onclickedDisLike_0,
                              icon: Icon(disLike_0
                                  ? Icons.thumb_down
                                  : Icons.thumb_down_outlined)),
                        ],
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Text('익명', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 15),
                          Text('유튜브에 좋은 자료가 많으니 확인해보세요.'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: onclickedLike_1,
                            icon: Icon(isLike_1
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined),
                          ),
                          IconButton(
                              onPressed: onclickedDisLike_1,
                              icon: Icon(disLike_1
                                  ? Icons.thumb_down
                                  : Icons.thumb_down_outlined)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  //댓글 끝

                  //Commnet 창
                  const Row(
                    children: [SizedBox(width: 15), Text('Comment')],
                  ),
                  Container(
                    width: 370,
                    height: 70,
                    decoration: ShapeDecoration(
                        color: const Color.fromRGBO(246, 184, 184, 1.0),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15))),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
