import 'package:flutter/material.dart';
import 'package:loa/main.dart';
import 'loadrawer.dart';
import 'package:loa/noteShareList.dart';
// 조찬희 템플릿 작성, 최준혁 DB 및 통신 연결
class NoteShareInit extends StatelessWidget {

  @override

  final List<Map<String, dynamic>> course = [
    {
      'name': '모바일 프로그래밍',
      'professor': '김부근 교수'
    },
    {
      'name':'멀티코어 컴퓨팅',
      'professor':'김준영 교수'
    },
    {
      'name':'알고리즘',
      'professor':'조윤식 교수'
    },
    {
      'name':'데이터베이스 설계',
      'professor':'이재성 교수'
    },
    {
      'name':'이산수학',
      'professor':'이창희 교수'
    }

  ];
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
          '노트 공유',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: LoaDrawer(),

      body: showlist(),
    );
  }
  Widget showlist(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: course.length,
      itemBuilder: (BuildContext context, int i){
        String subject = course[i]['name'];
        String professer = course[i]['professor'];

        return Column(
          children: [
            Container(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteShareList(subject: subject),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,10),
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
                        width: 20
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
                        Text(subject,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600
                          ),),
                        Text(professer,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w200
                          ),)
                      ],
                    ),
                    Expanded(child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.chevron_right,
                            size: 50, //Icon Size
                          ),
                        ],
                      ),
                    ))

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
