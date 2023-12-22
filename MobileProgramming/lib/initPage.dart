import 'package:flutter/material.dart';
import 'package:loa/main.dart';
import 'package:loa/login.dart';
import 'package:loa/signup.dart';
import 'loadrawer.dart';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 80, 80, 80),
              child: Container(

                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50.0)
                  ),
                  child:
                  Show_User_profile()
              ),
            ),

            Container(
              child: Center(
                child: Text(
                  'Loa 버전 2를 기대하세요!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  //user profile 내용 colunm으로 return
  Widget Show_User_profile() {
    final List<Map<String, dynamic>> User_Profile = [
      {
        'Name': '푸앙이',
        'School': '중앙대학교',
        'Dept': 'AI학과',
        'Score': '88.6',
        'Rank': '1/12',
        'Point': '32pt'
      }
    ];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: User_Profile.length,
      itemBuilder: (BuildContext context, int i) {
        String Name = User_Profile[i]['Name'];
        String School = User_Profile[i]['School'];
        String Dept = User_Profile[i]['Dept'];
        String Score = User_Profile[i]['Score'];
        String Rank = User_Profile[i]['Rank'];
        String Point = User_Profile[i]['Point'];

        return Column(
          children: [
            SizedBox(height: 50,),
            Text("Profile",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22

            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("Name: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  )),
                  Text(Name,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("School: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  )),
                  Text(School,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("Dept: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  )),
                  Text(Dept,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("Score: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  )),
                  Text(Score,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("Rank: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  )),
                  Text(Rank,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,30,0),
              child: Row(
                children: [
                  Text("Point: ", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  )),
                  Text(Point,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22

                  ))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}